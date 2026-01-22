– ========================================
– BÀI TẬP QUẢN LÝ NHÂN VIÊN - ASSIGNMENT 1
– ========================================

– Tạo database
CREATE DATABASE IF NOT EXISTS QLNV;
USE QLNV;

– ========================================
– CÂU 1: TẠO CÁC BẢNG DỮ LIỆU
– ========================================

– Bảng Phong: Lưu trữ thông tin về các phòng ban
CREATE TABLE Phong (
maph CHAR(3) PRIMARY KEY,
tenph NVARCHAR(40) NOT NULL,
diachi NVARCHAR(50),
tel CHAR(10)
);

– Bảng DMNN: Danh mục ngoại ngữ
CREATE TABLE DMNN (
mann CHAR(2) PRIMARY KEY,
tennn NVARCHAR(20) NOT NULL
);

– Bảng NhanVien: Lưu trữ thông tin các nhân viên
CREATE TABLE NhanVien (
manv CHAR(5) PRIMARY KEY,
hoten NVARCHAR(40) NOT NULL,
gioitinh NCHAR(3) CHECK (gioitinh IN (N’Nam’, N’Nữ’)),
ngaysinh DATE,
luong INT,
maph CHAR(3),
sdt CHAR(10),
ngaybc DATE,
FOREIGN KEY (maph) REFERENCES Phong(maph)
);

– Bảng TDNN: Trình độ ngoại ngữ của nhân viên
CREATE TABLE TDNN (
manv CHAR(5),
mann CHAR(2),
tdo CHAR(1) CHECK (tdo IN (‘A’, ‘B’, ‘C’, ‘D’, ‘E’)),
PRIMARY KEY (manv, mann),
FOREIGN KEY (manv) REFERENCES NhanVien(manv),
FOREIGN KEY (mann) REFERENCES DMNN(mann)
);

– ========================================
– NHẬP DỮ LIỆU VÀO CÁC BẢNG
– ========================================

– Nhập dữ liệu bảng Phong
INSERT INTO Phong (maph, tenph, diachi, tel) VALUES
(‘HCA’, N’Hành chính’, N’371 NK’, ‘0362588541’),
(‘KDA’, N’Kinh doanh’, N’371 NK’, ‘0362517395’),
(‘KTA’, N’Kỹ thuật’, N’371 NK’, ‘0362567401’),
(‘QTA’, N’Quản trị’, N’371 NK’, ‘0362565788’);

– Nhập dữ liệu bảng DMNN
INSERT INTO DMNN (mann, tennn) VALUES
(‘01’, N’Anh’),
(‘02’, N’Nga’),
(‘03’, N’Pháp’),
(‘04’, N’Nhật’),
(‘05’, N’Trung Quốc’),
(‘06’, N’Hàn Quốc’);

– Nhập dữ liệu bảng NhanVien
INSERT INTO NhanVien (manv, hoten, gioitinh, ngaysinh, luong, maph, sdt, ngaybc) VALUES
(‘HC001’, N’Nguyễn Thị Hà’, N’Nữ’, ‘1966-08-27’, 7500000, ‘HCA’, NULL, ‘1995-02-08’),
(‘HC002’, N’Trần Văn Nam’, N’Nam’, ‘1995-12-06’, 8000000, ‘HCA’, NULL, ‘2017-08-06’),
(‘HC003’, N’Nguyễn Thanh Huyền’, N’Nữ’, ‘1998-03-07’, 6500000, ‘HCA’, NULL, ‘2019-09-24’),
(‘KD001’, N’Lê Tuyết Anh’, N’Nữ’, ‘1992-03-02’, 7500000, ‘KDA’, NULL, ‘2021-02-10’),
(‘KD002’, N’Nguyễn Anh Tú’, N’Nam’, ‘1962-04-07’, 7600000, ‘KDA’, NULL, ‘2000-07-14’),
(‘KD003’, N’Phạm An Thái’, N’Nam’, ‘1977-09-05’, 6600000, ‘KDA’, NULL, ‘2019-10-13’),
(‘KD004’, N’Lê Văn Hải’, N’Nam’, ‘1976-02-01’, 7900000, ‘KDA’, NULL, ‘2017-08-06’),
(‘KD005’, N’Nguyễn Phương Minh’, N’Nam’, ‘1980-02-01’, 7000000, ‘KDA’, NULL, ‘2021-02-10’),
(‘KT001’, N’Trần Đình Khâm’, N’Nam’, ‘1971-02-12’, 7700000, ‘KTA’, NULL, ‘2022-01-01’),
(‘KT003’, N’Phạm Thanh Sơn’, N’Nam’, ‘1994-08-20’, 7100000, ‘KTA’, NULL, ‘2022-01-01’),
(‘KT004’, N’Vũ Thị Hoài’, N’Nữ’, ‘1995-05-12’, 7500000, ‘KTA’, NULL, ‘2021-10-02’),
(‘KT005’, N’Nguyễn Thu Lan’, N’Nữ’, ‘1994-05-10’, 8000000, ‘KTA’, NULL, ‘2021-02-10’),
(‘KT006’, N’Trần Hoài Nam’, N’Nam’, ‘1978-02-07’, 7800000, ‘KTA’, NULL, ‘2017-08-06’),
(‘TT001’, N’Hoàng Nam Sơn’, N’Nam’, ‘1969-03-12’, 8200000, NULL, NULL, ‘2015-07-02’),
(‘KT008’, N’Lê Thu Trang’, N’Nữ’, ‘1970-06-07’, 7500000, ‘KTA’, NULL, ‘2018-02-08’),
(‘KT009’, N’Khúc Nam Hải’, N’Nam’, ‘1980-07-22’, 7000000, ‘KTA’, NULL, ‘2015-01-01’),
(‘TT002’, N’Phùng Trung Dũng’, N’Nam’, ‘1978-08-28’, 7200000, NULL, NULL, ‘2012-09-24’);

– Nhập dữ liệu bảng TDNN
INSERT INTO TDNN (manv, mann, tdo) VALUES
(‘HC001’, ‘01’, ‘A’), (‘HC001’, ‘02’, ‘B’),
(‘HC002’, ‘01’, ‘C’), (‘HC002’, ‘03’, ‘C’),
(‘HC003’, ‘01’, ‘D’),
(‘KD001’, ‘01’, ‘C’), (‘KD001’, ‘02’, ‘B’),
(‘KD002’, ‘01’, ‘D’), (‘KD002’, ‘02’, ‘A’),
(‘KD003’, ‘01’, ‘B’), (‘KD003’, ‘02’, ‘C’),
(‘KD004’, ‘01’, ‘C’), (‘KD004’, ‘04’, ‘A’), (‘KD004’, ‘05’, ‘A’),
(‘KD005’, ‘01’, ‘B’), (‘KD005’, ‘02’, ‘D’), (‘KD005’, ‘03’, ‘B’), (‘KD005’, ‘04’, ‘B’),
(‘KT001’, ‘01’, ‘D’), (‘KT001’, ‘04’, ‘E’),
(‘KT003’, ‘01’, ‘D’), (‘KT003’, ‘03’, ‘C’),
(‘KT004’, ‘01’, ‘D’), (‘KT004’, ‘03’, ‘A’),
(‘KT005’, ‘01’, ‘C’), (‘KT005’, ‘02’, ‘A’), (‘KT005’, ‘04’, ‘B’),
(‘KT006’, ‘01’, ‘B’), (‘KT006’, ‘03’, ‘C’),
(‘KT008’, ‘01’, ‘B’), (‘KT008’, ‘02’, ‘D’), (‘KT008’, ‘03’, ‘A’),
(‘TT002’, ‘01’, ‘B’), (‘TT002’, ‘02’, ‘C’), (‘TT002’, ‘03’, ‘A’), (‘TT002’, ‘04’, ‘D’);

– ========================================
– CÂU 2: KIỂM TRA VÀ BỔ SUNG RÀNG BUỘC
– ========================================

– Đã thêm các ràng buộc CHECK và FOREIGN KEY khi tạo bảng ở trên

– ========================================
– CÂU 3: THÊM NHÂN VIÊN QT001
– ========================================

INSERT INTO NhanVien (manv, hoten, gioitinh, ngaysinh, luong, maph, sdt, ngaybc)
VALUES (‘QT001’, N’Tên của bạn’, N’Nam’, ‘1990-01-01’, 9500000, ‘QTA’, NULL, CURDATE());

INSERT INTO TDNN (manv, mann, tdo) VALUES
(‘QT001’, ‘01’, ‘C’),  – Tiếng Anh trình độ C
(‘QT001’, ‘04’, ‘A’);  – Tiếng Nhật trình độ A

– ========================================
– CÂU 4: TÌM THÔNG TIN NHÂN VIÊN KD001
– ========================================

SELECT manv, hoten, maph, luong
FROM NhanVien
WHERE manv = ‘KD001’;

– ========================================
– CÂU 5: TÌM NHÂN VIÊN DƯỚI 32 TUỔI
– ========================================

SELECT *, YEAR(CURDATE()) - YEAR(ngaysinh) AS tuoi
FROM NhanVien
WHERE YEAR(CURDATE()) - YEAR(ngaysinh) < 32;

– ========================================
– CÂU 6: NHÂN VIÊN CÓ NGOẠI NGỮ 01 TRÌNH ĐỘ C TRỞ LÊN
– ========================================

SELECT DISTINCT nv.*
FROM NhanVien nv
JOIN TDNN td ON nv.manv = td.manv
WHERE td.mann = ‘01’ AND td.tdo IN (‘A’, ‘B’, ‘C’);

– ========================================
– CÂU 7: NHÂN VIÊN ĐÃ VÀO BIÊN CHẾ HƠN 10 NĂM
– ========================================

SELECT *, YEAR(CURDATE()) - YEAR(ngaybc) AS sonambc
FROM NhanVien
WHERE YEAR(CURDATE()) - YEAR(ngaybc) > 10;

– ========================================
– CÂU 8: NHÂN VIÊN ĐỦ TUỔI NGHỈ HƯU
– ========================================

SELECT *, YEAR(CURDATE()) - YEAR(ngaysinh) AS tuoi
FROM NhanVien
WHERE (gioitinh = N’Nam’ AND YEAR(CURDATE()) - YEAR(ngaysinh) >= 60)
OR (gioitinh = N’Nữ’ AND YEAR(CURDATE()) - YEAR(ngaysinh) >= 55);

– ========================================
– CÂU 9: NHÂN VIÊN CÓ LƯƠNG 7-8 TRIỆU
– ========================================

SELECT manv, hoten, ngaysinh, luong
FROM NhanVien
WHERE luong BETWEEN 7000000 AND 8000000;

– ========================================
– CÂU 10: DANH SÁCH NHÂN VIÊN TĂNG DẦN THEO LƯƠNG
– ========================================

SELECT *
FROM NhanVien
ORDER BY luong ASC;

– ========================================
– CÂU 11: TỔNG SỐ NHÂN VIÊN VÀ LƯƠNG TB PHÒNG KINH DOANH
– ========================================

SELECT COUNT(*) AS TongSoNV, AVG(luong) AS LuongTrungBinh
FROM NhanVien
WHERE maph = ‘KDA’;

– ========================================
– CÂU 12: DANH SÁCH MÃ NV, HỌ TÊN, MÃ PHÒNG, TÊN PHÒNG
– ========================================

SELECT nv.manv, nv.hoten, nv.maph, p.tenph
FROM NhanVien nv
LEFT JOIN Phong p ON nv.maph = p.maph;

– ========================================
– CÂU 13: NHÂN VIÊN CÓ TUỔI LỚN HƠN ĐỘ TUỔI TRUNG BÌNH
– ========================================

SELECT *, YEAR(CURDATE()) - YEAR(ngaysinh) AS tuoi
FROM NhanVien
WHERE YEAR(CURDATE()) - YEAR(ngaysinh) > (
SELECT AVG(YEAR(CURDATE()) - YEAR(ngaysinh))
FROM NhanVien
);

– ========================================
– CÂU 14: NHÂN VIÊN CÓ NHIỀU HƠN 2 NGOẠI NGỮ
– ========================================

SELECT nv.manv, nv.hoten, COUNT(td.mann) AS SoNgoaiNgu
FROM NhanVien nv
JOIN TDNN td ON nv.manv = td.manv
GROUP BY nv.manv, nv.hoten
HAVING COUNT(td.mann) > 2;

– ========================================
– CÂU 15: NHÂN VIÊN VÀO BIÊN CHẾ TRƯỚC 1/1/2017 PHÒNG KỸ THUẬT/KINH DOANH
– ========================================

SELECT *
FROM NhanVien
WHERE ngaybc < ‘2017-01-01’
AND maph IN (‘KTA’, ‘KDA’);

– ========================================
– CÂU 16: SẮP XẾP THEO TÊN TĂNG DẦN, TRÙNG THÌ GIẢM DẦN THEO NGÀY SINH
– ========================================

SELECT *
FROM NhanVien
ORDER BY
SUBSTRING_INDEX(hoten, ’ ’, -1) ASC,
ngaysinh DESC;

– ========================================
– CÂU 17: NHÂN VIÊN HỌC TIẾNG ANH HOẶC PHÁP, TRÌNH ĐỘ C TRỞ LÊN
– ========================================

SELECT DISTINCT nv.manv, nv.hoten, nv.ngaysinh, nn.tennn, td.tdo
FROM NhanVien nv
JOIN TDNN td ON nv.manv = td.manv
JOIN DMNN nn ON td.mann = nn.mann
WHERE td.mann IN (‘01’, ‘03’)
AND td.tdo IN (‘A’, ‘B’, ‘C’);

– ========================================
– CÂU 18: NGOẠI NGỮ CHƯA CÓ NHÂN VIÊN HỌC
– ========================================

SELECT nn.*
FROM DMNN nn
LEFT JOIN TDNN td ON nn.mann = td.mann
WHERE td.mann IS NULL;

– ========================================
– CÂU 19: NHÂN VIÊN CHƯA HỌC BẤT KỲ NGOẠI NGỮ NÀO
– ========================================

SELECT nv.*
FROM NhanVien nv
LEFT JOIN TDNN td ON nv.manv = td.manv
WHERE td.manv IS NULL;

– ========================================
– CÂU 20: NHÂN VIÊN BIẾT TỪ 3 NGOẠI NGỮ TRỞ LÊN
– ========================================

SELECT nv.manv, nv.hoten, COUNT(td.mann) AS SoNgoaiNgu
FROM NhanVien nv
JOIN TDNN td ON nv.manv = td.manv
GROUP BY nv.manv, nv.hoten
HAVING COUNT(td.mann) >= 3;

– ========================================
– CÂU 21: TĂNG LƯƠNG NHÂN VIÊN PHÒNG KỸ THUẬT 15%
– ========================================

UPDATE NhanVien
SET luong = luong * 1.15
WHERE maph = ‘KTA’;

– Kiểm tra kết quả
SELECT manv, hoten, maph, luong
FROM NhanVien
WHERE maph = ‘KTA’;

– ========================================
– CÂU 22: TẠO BẢNG NGHI_HUU VÀ CHUYỂN DỮ LIỆU
– ========================================

– Tạo bảng NGHI_HUU
CREATE TABLE NGHI_HUU (
manv CHAR(5) PRIMARY KEY,
hoten NVARCHAR(40) NOT NULL,
gioitinh NCHAR(3),
ngaysinh DATE,
luong INT,
maph CHAR(3),
sdt CHAR(10),
ngaybc DATE
);

– Chuyển nhân viên đủ tuổi nghỉ hưu vào bảng NGHI_HUU
INSERT INTO NGHI_HUU
SELECT *
FROM NhanVien
WHERE (gioitinh = N’Nam’ AND YEAR(CURDATE()) - YEAR(ngaysinh) >= 60)
OR (gioitinh = N’Nữ’ AND YEAR(CURDATE()) - YEAR(ngaysinh) >= 55);

– Xóa nhân viên đã nghỉ hưu khỏi bảng NhanVien
DELETE FROM NhanVien
WHERE (gioitinh = N’Nam’ AND YEAR(CURDATE()) - YEAR(ngaysinh) >= 60)
OR (gioitinh = N’Nữ’ AND YEAR(CURDATE()) - YEAR(ngaysinh) >= 55);

– Kiểm tra kết quả
SELECT * FROM NGHI_HUU;
SELECT * FROM NhanVien;
