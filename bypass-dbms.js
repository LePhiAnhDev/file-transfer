const CONFIG = {
    url: "https://answer-gdu.web.app",
    fields: {
        mssv: "mssv",
        hoten: "hoten",
        answer: "answer_input"
    },
    timeout: {
        pageLoad: 500,
        retry: 1000
    }
};

async function main() {
    try {
        const { mssv, hoten } = await getStudentInfo();
        const tsqlCode = await getCodeFromClipboard();
        await openAndFillForm(mssv, hoten, tsqlCode);
    } catch (error) {
        await showError(error.message);
        console.error("Error:", error);
    }
}

async function getStudentInfo() {
    const alert = new Alert();
    alert.title = "Nhập thông tin sinh viên";
    alert.message = "Vui lòng điền đầy đủ thông tin";
    alert.addTextField("MSSV", "");
    alert.addTextField("Họ và Tên", "");
    alert.addAction("Tiếp tục");
    alert.addCancelAction("Hủy");
    
    const response = await alert.presentAlert();
    if (response === -1) {
        throw new Error("Đã hủy nhập thông tin");
    }
    
    const mssv = alert.textFieldValue(0)?.trim();
    const hoten = alert.textFieldValue(1)?.trim();
    
    if (!mssv || !hoten) {
        throw new Error("MSSV và Họ Tên không được để trống");
    }
    
    return { mssv, hoten };
}

async function getCodeFromClipboard() {
    const alert = new Alert();
    alert.title = "Nhập Code TSQL";
    alert.message = "Vui lòng:\n1. Copy code TSQL vào clipboard\n2. Nhấn OK để tiếp tục";
    alert.addAction("OK");
    alert.addCancelAction("Hủy");
    
    const response = await alert.presentAlert();
    if (response === -1) {
        throw new Error("Đã hủy nhập TSQL");
    }
    
    const code = Pasteboard.paste();
    if (!code || code.trim() === "") {
        throw new Error("Clipboard trống! Vui lòng copy code TSQL trước");
    }
    
    const confirmed = await confirmCode(code);
    if (!confirmed) {
        throw new Error("Đã hủy xác nhận code");
    }
    
    return code;
}

async function confirmCode(code) {
    const alert = new Alert();
    alert.title = "Xác nhận Code";
    
    const preview = code.length > 200 ? code.substring(0, 200) + "..." : code;
    alert.message = `Code TSQL đã lấy:\n\n${preview}\n\nDài: ${code.length} ký tự`;
    
    alert.addAction("OK");
    alert.addCancelAction("Hủy");
    
    const response = await alert.presentAlert();
    return response !== -1;
}

async function openAndFillForm(mssv, hoten, tsqlCode) {
    const jsCode = generateInjectionScript(mssv, hoten, tsqlCode);
    
    const webView = new WebView();
    await webView.loadURL(CONFIG.url);
    await webView.waitForLoad();
    await sleep(CONFIG.timeout.pageLoad);
    await webView.evaluateJavaScript(jsCode);
    await webView.present(true);
    
    console.log("Script hoàn thành");
}

function generateInjectionScript(mssv, hoten, tsqlCode) {
    return `
(function() {
    function fillForm() {
        try {
            const mssvInput = document.getElementById("${CONFIG.fields.mssv}");
            const hotenInput = document.getElementById("${CONFIG.fields.hoten}");
            const answerInput = document.getElementById("${CONFIG.fields.answer}");
            
            if (!mssvInput || !hotenInput || !answerInput) {
                return false;
            }
            
            mssvInput.value = ${JSON.stringify(mssv)};
            hotenInput.value = ${JSON.stringify(hoten)};
            answerInput.value = ${JSON.stringify(tsqlCode)};
            
            [mssvInput, hotenInput, answerInput].forEach(input => {
                input.dispatchEvent(new Event('input', { bubbles: true }));
                input.dispatchEvent(new Event('change', { bubbles: true }));
            });
            
            return true;
        } catch(e) {
            console.error("Form fill error:", e);
            return false;
        }
    }
    
    if (!fillForm()) {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', fillForm);
        } else {
            setTimeout(fillForm, ${CONFIG.timeout.pageLoad});
            setTimeout(fillForm, ${CONFIG.timeout.retry});
        }
    }
})();
`;
}

async function showError(message) {
    const alert = new Alert();
    alert.title = "Lỗi";
    alert.message = message;
    alert.addAction("OK");
    await alert.presentAlert();
}

function sleep(ms) {
    return new Promise(resolve => Timer.schedule(ms, false, resolve));
}

await main();
