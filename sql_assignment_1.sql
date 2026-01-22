--------------------------------------------------------------------------------
-- PHẦN 1: TẠO DATABASE VÀ CÁC BẢNG (CÂU 1 & 2)
--------------------------------------------------------------------------------
USE master;
GO

-- Kiểm tra nếu DB đã tồn tại thì xóa để tạo lại (giúp chạy lại nhiều lần không lỗi)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QLNV')
    DROP DATABASE QLNV;
GO

CREATE DATABASE QLNV;
GO
USE QLNV;
GO

-- Định dạng ngày tháng (DD/MM/YYYY) để tránh lỗi khi insert
SET DATEFORMAT dmy;
GO

-- 1. Tạo bảng PHONG
CREATE TABLE Phong (
    maph CHAR(3) PRIMARY KEY,
    tenph NVARCHAR(40),
    diachi NVARCHAR(50),
    tel CHAR(10)
);

-- 2. Tạo bảng DMNN (Danh mục ngoại ngữ)
CREATE TABLE DMNN (
    mann CHAR(2) PRIMARY KEY,
    tennn NVARCHAR(20)
);

-- 3. Tạo bảng NHANVIEN
CREATE TABLE NhanVien (
    manv CHAR(5) PRIMARY KEY,
    hoten NVARCHAR(40),
    gioitinh NCHAR(3),
    ngaysinh DATE,
    luong INT,
    maph CHAR(3),
    sdt CHAR(10),
    ngaybc DATE,
    -- Câu 2: Bổ sung ràng buộc khóa ngoại tham chiếu đến bảng Phong
    CONSTRAINT FK_NhanVien_Phong FOREIGN KEY (maph) REFERENCES Phong(maph)
);

-- 4. Tạo bảng TDNN (Trình độ ngoại ngữ)
CREATE TABLE TDNN (
    manv CHAR(5),
    mann CHAR(2),
    tdo CHAR(1),
    PRIMARY KEY (manv, mann),
    -- Câu 2: Bổ sung các ràng buộc khóa ngoại
    CONSTRAINT FK_TDNN_NhanVien FOREIGN KEY (manv) REFERENCES NhanVien(manv),
    CONSTRAINT FK_TDNN_DMNN FOREIGN KEY (mann) REFERENCES DMNN(mann)
);

--------------------------------------------------------------------------------
-- PHẦN 2: INSERT DỮ LIỆU (DỮ LIỆU TỪ HÌNH 2)
--------------------------------------------------------------------------------
-- Thêm dữ liệu bảng Phong
INSERT INTO Phong (maph, tenph, diachi, tel) VALUES 
('HCA', N'Hành chính', N'371 NK', '0362588541'),
('KDA', N'Kinh doanh', N'371 NK', '0362517395'),
('KTA', N'Kỹ thuật',   N'371 NK', '0362567401'),
('QTA', N'Quản trị',   N'371 NK', '0362565788');

-- Thêm dữ liệu bảng DMNN
INSERT INTO DMNN (mann, tennn) VALUES 
('01', N'Anh'),
('02', N'Nga'),
('03', N'Pháp'),
('04', N'Nhật'),
('05', N'Trung Quốc'),
('06', N'Hàn Quốc');

-- Thêm dữ liệu bảng NhanVien
INSERT INTO NhanVien (manv, hoten, gioitinh, ngaysinh, luong, maph, sdt, ngaybc) VALUES 
('HC001', N'Nguyễn Thị Hà',      N'Nữ',  '27/08/1966', 7500000, 'HCA', NULL, '02/08/1995'),
('HC002', N'Trần Văn Nam',       N'Nam', '06/12/1995', 8000000, 'HCA', NULL, '06/08/2017'),
('HC003', N'Nguyễn Thanh Huyền', N'Nữ',  '07/03/1998', 6500000, 'HCA', NULL, '24/09/2019'),
('KD001', N'Lê Tuyết Anh',       N'Nữ',  '02/03/1992', 7500000, 'KDA', NULL, '10/02/2021'),
('KD002', N'Nguyễn Anh Tú',      N'Nam', '07/04/1962', 7600000, 'KDA', NULL, '14/07/2000'),
('KD003', N'Phạm An Thái',       N'Nam', '05/09/1977', 6600000, 'KDA', NULL, '13/10/2019'),
('KD004', N'Lê Văn Hải',         N'Nam', '01/02/1976', 7900000, 'KDA', NULL, '06/08/2017'),
('KD005', N'Nguyễn Phương Minh', N'Nam', '01/02/1980', 7000000, 'KDA', NULL, '10/02/2021'),
('KT001', N'Trần Đình Khâm',     N'Nam', '12/02/1971', 7700000, 'KTA', NULL, '01/01/2022'),
('KT003', N'Phạm Thanh Sơn',     N'Nam', '20/08/1994', 7100000, 'KTA', NULL, '01/01/2022'),
('KT004', N'Vũ Thị Hoài',        N'Nữ',  '12/05/1995', 7500000, 'KTA', NULL, '10/02/2021'),
('KT005', N'Nguyễn Thu Lan',     N'Nữ',  '10/05/1994', 8000000, 'KTA', NULL, '10/02/2021'),
('KT006', N'Trần Hoài Nam',      N'Nam', '07/02/1978', 7800000, 'KTA', NULL, '06/08/2017'),
('TT001', N'Hoàng Nam Sơn',      N'Nam', '12/03/1969', 8200000, 'KTA', NULL, '07/02/2015'), -- Lưu ý: Trong ảnh TT001 mã phòng NULL hoặc thiếu, tôi gán tạm KTA để tránh lỗi FK nếu logic yêu cầu
('KT008', N'Lê Thu Trang',       N'Nữ',  '07/06/1970', 7500000, 'KTA', NULL, '08/02/2018'),
('KT009', N'Khúc Nam Hải',       N'Nam', '22/07/1980', 7000000, 'KTA', NULL, '01/01/2015'),
('TT002', N'Phùng Trung Dũng',   N'Nam', '28/08/1978', 7200000, 'KTA', NULL, '24/09/2012'); -- Gán tạm KTA

-- Thêm dữ liệu bảng TDNN
INSERT INTO TDNN (manv, mann, tdo) VALUES 
('HC001', '01', 'A'), ('HC001', '02', 'B'),
('HC002', '01', 'C'), ('HC002', '03', 'C'),
('HC003', '01', 'D'),
('KD001', '01', 'C'), ('KD001', '02', 'B'),
('KD002', '01', 'D'), ('KD002', '02', 'A'),
('KD003', '01', 'B'), ('KD003', '02', 'C'),
('KD004', '01', 'C'), ('KD004', '04', 'A'), ('KD004', '05', 'A'),
('KD005', '01', 'B'), ('KD005', '02', 'D'), ('KD005', '03', 'B'), ('KD005', '04', 'B'),
('KT001', '01', 'D'), ('KT001', '04', 'E'),
('KT003', '01', 'D'), ('KT003', '03', 'C'),
('KT004', '01', 'D'), ('KT004', '03', 'A'),
('KT005', '01', 'C'), ('KT005', '02', 'A'), ('KT005', '04', 'B'),
('KT006', '01', 'B'), ('KT006', '03', 'C'),
('KT008', '01', 'B'), ('KT008', '02', 'D'), ('KT008', '03', 'A'),
('TT002', '01', 'B'), ('TT002', '02', 'C'), ('TT002', '03', 'A'), ('TT002', '04', 'D');

--------------------------------------------------------------------------------
-- PHẦN 3: GIẢI QUYẾT CÁC YÊU CẦU TỪ CÂU 3 ĐẾN 22
--------------------------------------------------------------------------------

-- Câu 3: Thêm nhân viên mới (là chính bạn) vào phòng Quản trị (QTA)
-- Giả sử bạn tên là 'Nguyen Van A'
INSERT INTO NhanVien (manv, hoten, gioitinh, ngaysinh, luong, maph, sdt, ngaybc)
VALUES ('QT001', N'Nguyen Van A', N'Nam', '01/01/2000', 9500000, 'QTA', NULL, GETDATE());

INSERT INTO TDNN (manv, mann, tdo) VALUES 
('QT001', '01', 'C'), -- Tiếng Anh
('QT001', '04', 'A'); -- Tiếng Nhật

-- Câu 4: Tìm thông tin nhân viên KD001 (Họ tên, Phòng ban, Lương)
SELECT nv.hoten, p.tenph, nv.luong 
FROM NhanVien nv 
JOIN Phong p ON nv.maph = p.maph 
WHERE nv.manv = 'KD001';

-- Câu 5: Tìm nhân viên tuổi dưới 32
SELECT hoten, ngaysinh, (YEAR(GETDATE()) - YEAR(ngaysinh)) AS Tuoi
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) < 32;

-- Câu 6: Nhân viên có ngoại ngữ 01 ở trình độ C trở lên (C, D, E...)
SELECT nv.manv, nv.hoten, td.mann, td.tdo 
FROM NhanVien nv 
JOIN TDNN td ON nv.manv = td.manv
WHERE td.mann = '01' AND td.tdo >= 'C';

-- Câu 7: Nhân viên đã vào biên chế hơn 10 năm
SELECT hoten, ngaybc, DATEDIFF(YEAR, ngaybc, GETDATE()) as SoNamBienChe
FROM NhanVien
WHERE DATEDIFF(YEAR, ngaybc, GETDATE()) > 10;

-- Câu 8: Nhân viên đến tuổi nghỉ hưu (Nam >= 60, Nữ >= 55)
SELECT * FROM NhanVien
WHERE (gioitinh = N'Nam' AND (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 60)
   OR (gioitinh = N'Nữ' AND (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 55);

-- Câu 9: Nhân viên có lương từ 7.000.000 đến 8.000.000
SELECT manv, hoten, ngaysinh, luong 
FROM NhanVien
WHERE luong BETWEEN 7000000 AND 8000000;

-- Câu 10: Danh sách nhân viên theo lương tăng dần
SELECT * FROM NhanVien ORDER BY luong ASC;

-- Câu 11: Tổng số NV và Lương trung bình phòng Kinh doanh
SELECT COUNT(manv) AS TongSoNV, AVG(luong) AS LuongTB
FROM NhanVien
WHERE maph IN (SELECT maph FROM Phong WHERE tenph = N'Kinh doanh');

-- Câu 12: Danh sách mã NV, họ tên, mã phòng, tên phòng
SELECT nv.manv, nv.hoten, p.maph, p.tenph 
FROM NhanVien nv 
JOIN Phong p ON nv.maph = p.maph;

-- Câu 13: Nhân viên có tuổi lớn hơn độ tuổi trung bình của cả công ty
SELECT hoten, (YEAR(GETDATE()) - YEAR(ngaysinh)) AS Tuoi
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) > (
    SELECT AVG(YEAR(GETDATE()) - YEAR(ngaysinh)) FROM NhanVien
);

-- Câu 14: Có bao nhiêu nhân viên biết nhiều hơn 2 ngoại ngữ?
SELECT COUNT(*) AS SoLuongNV_Hon2NN
FROM (
    SELECT manv FROM TDNN
    GROUP BY manv
    HAVING COUNT(mann) > 2
) AS SubList;

-- Câu 15: Nhân viên vào biên chế trước 1/1/2017 thuộc phòng Kỹ thuật hoặc Kinh doanh
SELECT * FROM NhanVien
WHERE ngaybc < '01/01/2017' 
AND maph IN (SELECT maph FROM Phong WHERE tenph IN (N'Kỹ thuật', N'Kinh doanh'));

-- Câu 16: Sắp xếp theo Tên (tăng dần), nếu trùng thì theo Ngày sinh (giảm dần)
-- (Sử dụng kỹ thuật tách tên khỏi họ)
SELECT * FROM NhanVien
ORDER BY 
    RIGHT(hoten, CHARINDEX(' ', REVERSE(hoten)) - 1) ASC, 
    ngaysinh DESC;

-- Câu 17: Tìm nhân viên học Tiếng Anh hoặc Pháp, trình độ C trở lên
SELECT nv.manv, nv.hoten, nv.ngaysinh, nn.tennn, td.tdo
FROM NhanVien nv
JOIN TDNN td ON nv.manv = td.manv
JOIN DMNN nn ON td.mann = nn.mann
WHERE (nn.tennn = N'Anh' OR nn.tennn = N'Pháp') 
AND td.tdo >= 'C';

-- Câu 18: Những ngoại ngữ nào chưa có nhân viên học?
SELECT * FROM DMNN
WHERE mann NOT IN (SELECT DISTINCT mann FROM TDNN);

-- Câu 19: Danh sách nhân viên chưa học bất kỳ ngoại ngữ nào
SELECT * FROM NhanVien
WHERE manv NOT IN (SELECT DISTINCT manv FROM TDNN);

-- Câu 20: Nhân viên biết từ 3 ngoại ngữ trở lên
SELECT nv.manv, nv.hoten, COUNT(td.mann) AS SoNgoaiNgu
FROM NhanVien nv
JOIN TDNN td ON nv.manv = td.manv
GROUP BY nv.manv, nv.hoten
HAVING COUNT(td.mann) >= 3;

-- Câu 21: Tăng lương nhân viên phòng Kỹ thuật thêm 15%
UPDATE NhanVien
SET luong = luong * 1.15
WHERE maph IN (SELECT maph FROM Phong WHERE tenph = N'Kỹ thuật');

-- Kiểm tra lại kết quả tăng lương (nếu cần)
-- SELECT * FROM NhanVien WHERE maph IN (SELECT maph FROM Phong WHERE tenph = N'Kỹ thuật');

-- Câu 22: Tạo bảng NGHI_HUU, sao chép dữ liệu và xóa khỏi bảng NhanVien
-- B1: Tạo bảng mới dựa trên cấu trúc bảng cũ (nhưng rỗng)
SELECT * INTO NGHI_HUU FROM NhanVien WHERE 1 = 0;

-- B2: Insert nhân viên nghỉ hưu vào bảng mới
INSERT INTO NGHI_HUU
SELECT * FROM NhanVien
WHERE (gioitinh = N'Nam' AND (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 60)
   OR (gioitinh = N'Nữ' AND (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 55);

-- B3: Xóa nhân viên đã nghỉ hưu khỏi bảng NhanVien
DELETE FROM NhanVien
WHERE manv IN (SELECT manv FROM NGHI_HUU);

-- Kiểm tra kết quả
SELECT * FROM NGHI_HUU; -- Danh sách đã chuyển sang
SELECT * FROM NhanVien; -- Danh sách còn lại
