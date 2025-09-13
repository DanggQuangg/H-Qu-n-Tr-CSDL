-- Tạo database
CREATE DATABASE QUANLYRAPPHIM;
GO

USE QUANLYRAPPHIM;
GO

/**************************************************
 * Bảng Nhân viên
 **************************************************/
CREATE TABLE NHANVIEN (
    MANV NVARCHAR(10) NOT NULL PRIMARY KEY,
    HOTENNV NVARCHAR(100) NOT NULL,
    DIACHINV NVARCHAR(500) NULL,
    SDTNV NVARCHAR(20) NULL,
    NGAYSINHNV DATE NULL,
    GIOITINH TINYINT NULL, -- 0 = Nam, 1 = Nữ, 2 = Khác
    LUONG DECIMAL(18,2) NULL,
    NGAYVAOLAM DATE NULL
);
GO

/**************************************************
 * Bảng Khuyến mãi
 * - MAKM: mã khuyến mãi
 * - GIAKM: số tiền giảm (có thể là %, hoặc tiền - nếu muốn thêm thì thêm kiểu)
 **************************************************/
CREATE TABLE KHUYENMAI (
    MAKM NVARCHAR(10) NOT NULL PRIMARY KEY,
    TENGIAM NVARCHAR(100) NULL,
    LOAIGIAM NVARCHAR(20) NOT NULL DEFAULT('TIEN'), -- 'TIEN' hoặc 'PHANTRAM'
    GIATRI DECIMAL(18,2) NOT NULL DEFAULT(0), -- nếu LOAIGIAM='PHANTRAM' thì là phần trăm
    NGAYBATDAU DATE NULL,
    NGAYKETTHUC DATE NULL,
    MOTA NVARCHAR(500) NULL,
    CONSTRAINT CK_KHUYENMAI_NGAY CHECK (NGAYKETTHUC IS NULL OR NGAYBATDAU <= NGAYKETTHUC)
);
GO

/**************************************************
 * Bảng Loại vé
 **************************************************/
CREATE TABLE LOAIVE (
    MALOAI NVARCHAR(10) NOT NULL PRIMARY KEY,
    TENLOAI NVARCHAR(50) NOT NULL,
    GHICHU NVARCHAR(200) NULL
);
GO

/**************************************************
 * Bảng Khách hàng
 **************************************************/
CREATE TABLE KHACHHANG (
    MAKH NVARCHAR(10) NOT NULL PRIMARY KEY,
    HOTENKH NVARCHAR(100) NOT NULL,
    SDTKH NVARCHAR(20) NULL,
    DIACHIKH NVARCHAR(500) NULL,
    NGAYSINHKH DATE NULL,
    GIOITINH TINYINT NULL, -- 0 = Nam, 1 = Nữ, 2 = Khác
    EMAIL NVARCHAR(200) NULL,
    CONSTRAINT UQ_KH_EMAIL UNIQUE (EMAIL) -- nếu NULL thì không ảnh hưởng
);
GO

/**************************************************
 * Bảng Thể loại phim
 **************************************************/
CREATE TABLE THELOAIPHIM (
    MATLP NVARCHAR(10) NOT NULL PRIMARY KEY,
    TENLOAI NVARCHAR(50) NOT NULL
);
GO

/**************************************************
 * Bảng Phim
 **************************************************/
CREATE TABLE PHIM (
    MAPHIM NVARCHAR(10) NOT NULL PRIMARY KEY,
    MATLP NVARCHAR(10) NULL,
    TENPHIM NVARCHAR(200) NOT NULL,
    NHASX NVARCHAR(200) NULL,
    NGAYPHATHANH DATE NULL,
    THOILUONG_MIN INT NULL,       -- phút
    PHANLOAI_TUOI NVARCHAR(10) NULL, -- 'P', 'C13', 'C16', 'C18'...
    MOTA NVARCHAR(MAX) NULL,
    CONSTRAINT FK_PHIM_THELOAI FOREIGN KEY (MATLP) REFERENCES THELOAIPHIM (MATLP)
);
GO

/**************************************************
 * Bảng Phòng chiếu
 **************************************************/
CREATE TABLE PHONGCHIEU (
    MAPHONG NVARCHAR(10) NOT NULL PRIMARY KEY,
    TENPHONG NVARCHAR(50) NOT NULL,
    TONGSOGHE INT NOT NULL CHECK (TONGSOGHE > 0),
    MO_TA NVARCHAR(200) NULL
);
GO

/**************************************************
 * Bảng Ghế (một record cho một ghế trong phòng)
 **************************************************/
CREATE TABLE GHE (
    IDGHE INT IDENTITY(1,1) PRIMARY KEY,
    MAPHONG NVARCHAR(10) NOT NULL,
    DAYGHE NVARCHAR(5) NOT NULL, -- ví dụ: A, B, C
    SOGHE INT NOT NULL, -- số trong hàng
    UNIQUE (MAPHONG, DAYGHE, SOGHE),
    CONSTRAINT FK_GHE_PHONG FOREIGN KEY (MAPHONG) REFERENCES PHONGCHIEU (MAPHONG)
);
GO

/**************************************************
 * Bảng Suất chiếu
 * - mỗi suất liên kết tới 1 phim và 1 phòng
 **************************************************/
CREATE TABLE SUATCHIEU (
    MASUATCHIEU NVARCHAR(20) NOT NULL PRIMARY KEY,
    MAPHIM NVARCHAR(10) NOT NULL,
    MAPHONG NVARCHAR(10) NOT NULL,
    GIOBATDAU DATETIME NOT NULL,
    GIOKETTHUC DATETIME NOT NULL,
    GIABAN_COBAN DECIMAL(18,2) NULL, -- giá chuẩn (có thể thay đổi theo suất)
    CONSTRAINT FK_SUAT_PHIM FOREIGN KEY (MAPHIM) REFERENCES PHIM (MAPHIM),
    CONSTRAINT FK_SUAT_PHONG FOREIGN KEY (MAPHONG) REFERENCES PHONGCHIEU (MAPHONG),
    CONSTRAINT CK_SUATCHIEU_GIO CHECK (GIOBATDAU < GIOKETTHUC)
);
GO

/**************************************************
 * Bảng Vé
 * - mỗi vé thuộc 1 suất chiếu và 1 ghế
 * - MAKM (nullable) nếu khách áp dụng khuyến mãi
 * - MALOAI tham chiếu LOAIVE
 **************************************************/
CREATE TABLE VE (
    MAVE NVARCHAR(20) NOT NULL PRIMARY KEY,
    MASUATCHIEU NVARCHAR(20) NOT NULL,
    IDGHE INT NOT NULL,
    MALOAI NVARCHAR(10) NOT NULL,
    MAKH NVARCHAR(10) NULL,
    MANV NVARCHAR(10) NULL, -- người bán
    NGAYBAN DATETIME NOT NULL DEFAULT GETDATE(),
    GIAVE DECIMAL(18,2) NOT NULL,
    MAKM NVARCHAR(10) NULL,
    TRANGTHAI NVARCHAR(20) NOT NULL DEFAULT('DA_BAN'), -- 'DA_BAN', 'HUY', 'DAT_TRUOC'...
    CONSTRAINT FK_VE_SUATCHIEU FOREIGN KEY (MASUATCHIEU) REFERENCES SUATCHIEU (MASUATCHIEU),
    CONSTRAINT FK_VE_GHE FOREIGN KEY (IDGHE) REFERENCES GHE (IDGHE),
    CONSTRAINT FK_VE_LOAIVE FOREIGN KEY (MALOAI) REFERENCES LOAIVE (MALOAI),
    CONSTRAINT FK_VE_KHACHHANG FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH),
    CONSTRAINT FK_VE_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV),
    CONSTRAINT FK_VE_KHUYENMAI FOREIGN KEY (MAKM) REFERENCES KHUYENMAI (MAKM),
    -- đảm bảo không bán hai vé cho cùng 1 ghế cùng suất
    CONSTRAINT UQ_VE_UNIQUEGHE UNIQUE (MASUATCHIEU, IDGHE)
);
GO

/**************************************************
 * Bảng Quầy (quầy bán vé hoặc quầy đồ ăn)
 **************************************************/
CREATE TABLE QUAY (
    MAQUAY NVARCHAR(10) NOT NULL PRIMARY KEY,
    TENQUAY NVARCHAR(50) NOT NULL,
    LOAIQUAY NVARCHAR(20) NOT NULL -- 'VE' hoặc 'DOAN'
);
GO

/**************************************************
 * Bảng Đồ ăn
 **************************************************/
CREATE TABLE DOAN (
    MADOAN NVARCHAR(10) NOT NULL PRIMARY KEY,
    TENDOAN NVARCHAR(200) NOT NULL,
    LOAIDOAN NVARCHAR(50) NULL,
    GIADOAN DECIMAL(18,2) NOT NULL,
    SOLUONGTON INT NULL CHECK (SOLUONGTON >= 0),
    MOTA NVARCHAR(500) NULL
);
GO

/**************************************************
 * Bảng Đơn hàng đồ ăn (Orders for concessions)
 * - mỗi order có thể liên kết tới vé (tùy trường hợp khách đặt cùng vé)
 **************************************************/
CREATE TABLE DON_HANG_DOAN (
    MADON INT IDENTITY(1,1) PRIMARY KEY,
    MAVE NVARCHAR(20) NULL, -- nullable nếu mua lẻ
    MAKH NVARCHAR(10) NULL, -- nullable nếu khách vãng lai
    NGAYDAT DATETIME NOT NULL DEFAULT GETDATE(),
    TONGTIEN DECIMAL(18,2) NOT NULL,
    TRANGTHAI NVARCHAR(20) NOT NULL DEFAULT('MOI'),
    CONSTRAINT FK_DONHANG_VE FOREIGN KEY (MAVE) REFERENCES VE (MAVE),
    CONSTRAINT FK_DONHANG_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
);
GO

CREATE TABLE DON_HANG_CHI_TIET (
    MADON INT NOT NULL,
    MADOAN NVARCHAR(10) NOT NULL,
    SOLUONG INT NOT NULL CHECK (SOLUONG > 0),
    GIATIEN DECIMAL(18,2) NOT NULL, -- lưu giá tại thời điểm bán
    PRIMARY KEY (MADON, MADOAN),
    CONSTRAINT FK_DHCT_DON FOREIGN KEY (MADON) REFERENCES DON_HANG_DOAN (MADON),
    CONSTRAINT FK_DHCT_DOAN FOREIGN KEY (MADOAN) REFERENCES DOAN (MADOAN)
);
GO

/**************************************************
 * Nếu muốn lưu hành sử dụng quầy để bán vé:
 * Bảng LichSuBan (lưu lịch sử bán qua quầy)
 **************************************************/
CREATE TABLE LICHSUBAN_VE (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MAVE NVARCHAR(20) NOT NULL,
    MAQUAY NVARCHAR(10) NULL,
    MANV NVARCHAR(10) NULL,
    THOIGIAN DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_LSB_VE FOREIGN KEY (MAVE) REFERENCES VE (MAVE),
    CONSTRAINT FK_LSB_QUAY FOREIGN KEY (MAQUAY) REFERENCES QUAY (MAQUAY),
    CONSTRAINT FK_LSB_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)
);
GO

/**************************************************
 * Indexes đề xuất
 **************************************************/
CREATE INDEX IDX_SUATCHIEU_PHIM ON SUATCHIEU (MAPHIM);
CREATE INDEX IDX_SUATCHIEU_PHONG ON SUATCHIEU (MAPHONG);
CREATE INDEX IDX_VE_MAKH ON VE (MAKH);
CREATE INDEX IDX_VE_MANV ON VE (MANV);
GO

/**************************************************
 * Một số dữ liệu mẫu nhỏ (tùy chọn)
 **************************************************/
-- INSERT INTO LOAIVE (MALOAI, TENLOAI) VALUES ('THUONG', 'Vé thường'), ('VIP', 'Vé VIP'), ('HS', 'Học sinh');
-- INSERT INTO QUAY (MAQUAY, TENQUAY, LOAIQUAY) VALUES ('Q01','Quầy vé 1','VE'),('Q02','Quầy đồ ăn','DOAN');
GO

/**************************************************
 * Lưu ý vận hành:
 * - Khi tạo suất chiếu, đảm bảo các ghế cho phòng đó đã có trong bảng GHE.
 * - Giá vé thực tế có thể tính từ SUATCHIEU.GIABAN_COBA + phụ thu/giảm giá (MAKM).
 * - Đảm bảo cập nhật SOLUONGTON trong DOAN khi bán.
 **************************************************/
