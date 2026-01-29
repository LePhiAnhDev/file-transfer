-- Bài 1: Viết hàm xếp loại dựa vào điểm
CREATE OR ALTER FUNCTION dbo.fc_xeploai (@diem FLOAT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @xeploai NVARCHAR(20)

    SET @xeploai =
        CASE
            WHEN @diem >= 8 THEN N'Giỏi'
            WHEN @diem >= 7 THEN N'Khá'
            WHEN @diem >= 5 THEN N'TB'
            ELSE N'Yếu'
        END

    RETURN @xeploai
END
GO

-- Bài 2: Viết hàm đọc điểm nguyên ra chữ tương ứng
CREATE OR ALTER FUNCTION dbo.fc_docsonguyen (@diem INT)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @diemChu NVARCHAR(10)

    SET @diemChu =
        CASE
            WHEN @diem = 0  THEN N'Không'
            WHEN @diem = 1  THEN N'Một'
            WHEN @diem = 2  THEN N'Hai'
            WHEN @diem = 3  THEN N'Ba'
            WHEN @diem = 4  THEN N'Bốn'
            WHEN @diem = 5  THEN N'Năm'
            WHEN @diem = 6  THEN N'Sáu'
            WHEN @diem = 7  THEN N'Bảy'
            WHEN @diem = 8  THEN N'Tám'
            WHEN @diem = 9  THEN N'Chín'
            WHEN @diem = 10 THEN N'Mười'
            ELSE N'Không hợp lệ'
        END

    RETURN @diemChu
END
GO

-- Bài 3: Viết hàm đọc điểm 1 chữ số thập phân ra chữ
CREATE OR ALTER FUNCTION dbo.fc_docdiemthapphan (@diem NUMERIC(3,1))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @pn TINYINT
    DECLARE @ptp TINYINT
    DECLARE @kq NVARCHAR(20)

    SET @pn  = FLOOR(@diem)
    SET @ptp = (@diem * 10) % 10

    SET @kq = dbo.fc_docsonguyen(@pn)
              + N' phẩy '
              + dbo.fc_docsonguyen(@ptp)

    RETURN @kq
END
GO

-- Bài 4: Hàm tính điểm trung bình sinh viên theo học kỳ
CREATE OR ALTER FUNCTION dbo.fc_diem_sv
(
    @masv  CHAR(4),
    @hocky INT
)
RETURNS NUMERIC(3,1)
AS
BEGIN
    DECLARE @dtb NUMERIC(3,1)

    IF NOT EXISTS (SELECT 1 FROM dbo.KetQua WHERE masv = @masv)
        RETURN 0

    SELECT @dtb = ROUND(SUM(kq.diem * hp.stc) / SUM(hp.stc), 1)
    FROM dbo.HocPhan AS hp
    JOIN dbo.KetQua  AS kq
        ON hp.MaHP = kq.MaHP
    WHERE kq.masv = @masv
      AND hp.hocky = @hocky

    IF @dtb IS NULL
        SET @dtb = 0

    RETURN @dtb
END
GO

-- Bài 5: Hàm tính tổng số tín chỉ điểm < 8
CREATE OR ALTER FUNCTION dbo.fc_stc_sv (@masv CHAR(4))
RETURNS INT
AS
BEGIN
    DECLARE @stc INT

    IF NOT EXISTS (SELECT 1 FROM dbo.KetQua WHERE masv = @masv)
        RETURN 0

    SELECT @stc = SUM(hp.stc)
    FROM dbo.KetQua AS kq
    JOIN dbo.HocPhan AS hp
        ON kq.mahp = hp.mahp
    WHERE kq.masv = @masv
      AND kq.diem < 8

    IF @stc IS NULL
        SET @stc = 0

    RETURN @stc
END
GO

-- Bài 6: Hàm đếm số sinh viên điểm < 8 theo học phần
CREATE OR ALTER FUNCTION dbo.fc_dem_SV (@mahp CHAR(3))
RETURNS INT
AS
BEGIN
    DECLARE @nsv INT

    IF NOT EXISTS (SELECT 1 FROM dbo.KetQua WHERE mahp = @mahp)
        RETURN 0

    SELECT @nsv = COUNT(DISTINCT masv)
    FROM dbo.KetQua
    WHERE mahp = @mahp
      AND diem < 8

    IF @nsv IS NULL
        SET @nsv = 0

    RETURN @nsv
END
GO

-- Bài 7: Hàm đếm số học phần rớt (<5) của sinh viên
CREATE OR ALTER FUNCTION dbo.fc_dem_HP (@masv CHAR(4))
RETURNS INT
AS
BEGIN
    DECLARE @nhp INT

    IF NOT EXISTS (SELECT 1 FROM dbo.KetQua WHERE masv = @masv)
        RETURN 0

    SELECT @nhp = COUNT(DISTINCT mahp)
    FROM dbo.KetQua
    WHERE masv = @masv
      AND diem < 5

    IF @nhp IS NULL
        SET @nhp = 0

    RETURN @nhp
END
GO
