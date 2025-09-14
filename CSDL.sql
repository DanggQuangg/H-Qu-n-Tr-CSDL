-- Tạo database (nếu chưa có)
CREATE DATABASE QUANLYRAPPHIM;
GO

USE QUANLYRAPPHIM;
GO

/**************************************************
 * Bảng Tài khoản
 **************************************************/
CREATE TABLE TAIKHOAN (
    MATK INT IDENTITY(1,1) PRIMARY KEY,
    TK  VARCHAR(50)  NOT NULL UNIQUE,
    MK  VARCHAR(50)  NOT NULL,
    VAITRO NVARCHAR(20) NOT NULL
        CHECK (VAITRO IN (N'Khách hàng', N'Nhân viên', N'Quản lý'))
);
GO

/**************************************************
 * Bảng Quản lý
 **************************************************/
CREATE TABLE QUANLY (
    MAQL INT IDENTITY(1,1) PRIMARY KEY,
    HOTENQL   NVARCHAR(50),
    DIACHILQL NVARCHAR(50),
    GIOITINH  NVARCHAR(10) CHECK (GIOITINH IN (N'Nam', N'Nữ')),
    SDTQL     NVARCHAR(20) NULL,
    NGAYSINHQL DATE NULL,
    LUONG      DECIMAL(18,2) NULL,
    NGAYVAOLAM DATE NULL,
    MATK INT NULL,
    CONSTRAINT FK_QUANLY_TAIKHOAN
        FOREIGN KEY (MATK) REFERENCES TAIKHOAN(MATK)
);
GO

/**************************************************
 * Bảng Nhân viên
 **************************************************/
CREATE TABLE NHANVIEN (
    MANV INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    HOTENNV   NVARCHAR(100) NOT NULL,
    DIACHINV  NVARCHAR(500) NULL,
    SDTNV     NVARCHAR(20)  NULL,
    NGAYSINHNV DATE NULL,
    GIOITINH  NVARCHAR(10)  CHECK (GIOITINH IN (N'Nam', N'Nữ')),
    LUONG     DECIMAL(18,2) NULL,
    NGAYVAOLAM DATE NULL,
    MATK INT NULL,
    CONSTRAINT FK_NHANVIEN_TAIKHOAN
        FOREIGN KEY (MATK) REFERENCES TAIKHOAN(MATK)
);
GO

/**************************************************
 * Bảng Khuyến mãi
 * - LOAIGIAM: 'TIEN' hoặc 'PHANTRAM'
 * - GIATRI: nếu 'PHANTRAM' thì hiểu là %
 **************************************************/
CREATE TABLE KHUYENMAI (
    MAKM INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TENGIAM  NVARCHAR(100) NULL,
    LOAIGIAM NVARCHAR(20) NOT NULL
        CONSTRAINT CK_KM_LOAIGIAM CHECK (LOAIGIAM IN (N'TIEN', N'PHANTRAM')),
    GIATRI   DECIMAL(18,2) NOT NULL DEFAULT(0),
    NGAYBATDAU  DATE NULL,
    NGAYKETTHUC DATE NULL,
    MOTA NVARCHAR(500) NULL,
    CONSTRAINT CK_KHUYENMAI_NGAY
        CHECK (NGAYKETTHUC IS NULL OR NGAYBATDAU <= NGAYKETTHUC)
);
GO

/**************************************************
 * Bảng Loại vé
 **************************************************/
CREATE TABLE LOAIVE (
    MALOAI INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TENLOAI NVARCHAR(50) NOT NULL,
    GHICHU  NVARCHAR(200) NULL
);
GO

/**************************************************
 * Bảng Khách hàng
 **************************************************/
CREATE TABLE KHACHHANG (
    MAKH INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    HOTENKH   NVARCHAR(100) NOT NULL,
    SDTKH     VARCHAR(20)   NULL,
    DIACHIKH  NVARCHAR(500) NULL,
    NGAYSINHKH DATE NULL,
    GIOITINH  NVARCHAR(10)  CHECK (GIOITINH IN (N'Nam', N'Nữ')),
    EMAIL     NVARCHAR(200) NULL,
    MATK INT NOT NULL,
    CONSTRAINT FK_KHACHHANG_TAIKHOAN
        FOREIGN KEY (MATK) REFERENCES TAIKHOAN(MATK)
);
GO

-- Filtered unique index để cho phép nhiều NULL, tránh trùng khi có giá trị
CREATE UNIQUE INDEX UQ_KH_EMAIL_NOTNULL
    ON KHACHHANG(EMAIL) WHERE EMAIL IS NOT NULL;
GO

/**************************************************
 * Bảng Thể loại phim
 **************************************************/
CREATE TABLE THELOAIPHIM (
    MATLP INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TENLOAI NVARCHAR(50) NOT NULL
);
GO

/**************************************************
 * Bảng Phim
 **************************************************/
CREATE TABLE PHIM (
    MAPHIM INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MATLP INT NULL,
    TENPHIM NVARCHAR(200) NOT NULL,
    NHASX   NVARCHAR(200) NULL,
    NGAYPHATHANH DATE NULL,
    THOILUONG_MIN INT NULL,            -- phút
    PHANLOAI_TUOI VARCHAR(10) NULL,    -- 'P','C13','C16','C18',...
    MOTA NVARCHAR(MAX) NULL,
    CONSTRAINT FK_PHIM_THELOAI
        FOREIGN KEY (MATLP) REFERENCES THELOAIPHIM (MATLP),
    CONSTRAINT CK_PHIM_PLTUOI
        CHECK (PHANLOAI_TUOI IS NULL OR PHANLOAI_TUOI IN ('P','C13','C16','C18'))
);
GO

/**************************************************
 * Bảng Phòng chiếu
 **************************************************/
CREATE TABLE PHONGCHIEU (
    MAPHONG INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TENPHONG  NVARCHAR(50) NOT NULL,
    TONGSOGHE INT NOT NULL CHECK (TONGSOGHE > 0),
    MO_TA NVARCHAR(200) NULL
);
GO

/**************************************************
 * Bảng Ghế (một record cho một ghế trong phòng)
 **************************************************/
CREATE TABLE GHE (
    IDGHE INT IDENTITY(1,1) PRIMARY KEY,
    MAPHONG INT NOT NULL,
    DAYGHE  NVARCHAR(5) NOT NULL,  -- ví dụ: A, B, C
    SOGHE   INT NOT NULL,          -- số trong hàng
    CONSTRAINT UQ_GHE_UNIQUE
        UNIQUE (MAPHONG, DAYGHE, SOGHE),
    CONSTRAINT FK_GHE_PHONG
        FOREIGN KEY (MAPHONG) REFERENCES PHONGCHIEU (MAPHONG)
);
GO

/**************************************************
 * Bảng Suất chiếu (liên kết tới Phim + Phòng)
 **************************************************/
CREATE TABLE SUATCHIEU (
    MASUATCHIEU INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MAPHIM  INT NOT NULL,
    MAPHONG INT NOT NULL,
    GIOBATDAU  DATETIME NOT NULL,
    GIOKETTHUC DATETIME NOT NULL,
    GIABAN_COBAN DECIMAL(18,2) NULL, -- giá chuẩn (có thể thay đổi theo suất)
    CONSTRAINT FK_SUAT_PHIM
        FOREIGN KEY (MAPHIM) REFERENCES PHIM (MAPHIM),
    CONSTRAINT FK_SUAT_PHONG
        FOREIGN KEY (MAPHONG) REFERENCES PHONGCHIEU (MAPHONG),
    CONSTRAINT CK_SUATCHIEU_GIO
        CHECK (GIOBATDAU < GIOKETTHUC)
);
GO

/**************************************************
 * Bảng Vé
 * - mỗi vé thuộc 1 suất chiếu và 1 ghế
 * - MAKM (nullable) nếu khách áp dụng khuyến mãi
 * - MALOAI tham chiếu LOAIVE
 **************************************************/
CREATE TABLE VE (
    MAVE INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MASUATCHIEU INT NOT NULL,
    IDGHE INT NOT NULL,
    MALOAI INT NOT NULL,
    MAKH INT NULL,
    MANV INT NULL, -- người bán
    NGAYBAN DATETIME NOT NULL DEFAULT GETDATE(),
    GIAVE   DECIMAL(18,2) NOT NULL,
    MAKM INT NULL,
    TRANGTHAI NVARCHAR(20) NOT NULL DEFAULT(N'DA_BAN'),
    CONSTRAINT FK_VE_SUATCHIEU
        FOREIGN KEY (MASUATCHIEU) REFERENCES SUATCHIEU (MASUATCHIEU),
    CONSTRAINT FK_VE_GHE
        FOREIGN KEY (IDGHE) REFERENCES GHE (IDGHE),
    CONSTRAINT FK_VE_LOAIVE
        FOREIGN KEY (MALOAI) REFERENCES LOAIVE (MALOAI),
    CONSTRAINT FK_VE_KHACHHANG
        FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH),
    CONSTRAINT FK_VE_NHANVIEN
        FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV),
    CONSTRAINT FK_VE_KHUYENMAI
        FOREIGN KEY (MAKM) REFERENCES KHUYENMAI (MAKM),
    CONSTRAINT UQ_VE_UNIQUEGHE UNIQUE (MASUATCHIEU, IDGHE),
    CONSTRAINT CK_VE_TRANGTHAI
        CHECK (TRANGTHAI IN (N'DA_BAN', N'HUY', N'DAT_TRUOC'))
);
GO

/**************************************************
 * Bảng Quầy (quầy bán vé hoặc quầy đồ ăn)
 **************************************************/
CREATE TABLE QUAY (
    MAQUAY INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TENQUAY NVARCHAR(50) NOT NULL,
    LOAIQUAY NVARCHAR(20) NOT NULL,
    CONSTRAINT CK_QUAY_LOAI CHECK (LOAIQUAY IN (N'VE', N'DOAN'))
);
GO

/**************************************************
 * Bảng Đồ ăn
 **************************************************/
CREATE TABLE DOAN (
    MADOAN INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TENDOAN  NVARCHAR(200) NOT NULL,
    LOAIDOAN NVARCHAR(50)  NULL,
    GIADOAN  DECIMAL(18,2) NOT NULL,
    SOLUONGTON INT NULL CHECK (SOLUONGTON >= 0),
    MOTA NVARCHAR(500) NULL
);
GO

/**************************************************
 * Đơn hàng đồ ăn (có thể liên kết vé/khách)
 **************************************************/
CREATE TABLE DON_HANG_DOAN (
    MADON INT IDENTITY(1,1) PRIMARY KEY,
    MAVE INT NULL,  -- nullable nếu mua lẻ
    MAKH INT NULL,  -- nullable nếu khách vãng lai
    NGAYDAT DATETIME NOT NULL DEFAULT GETDATE(),
    TONGTIEN DECIMAL(18,2) NOT NULL,
    TRANGTHAI NVARCHAR(20) NOT NULL DEFAULT(N'MOI'),
    CONSTRAINT FK_DONHANG_VE FOREIGN KEY (MAVE) REFERENCES VE (MAVE),
    CONSTRAINT FK_DONHANG_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
);
GO

CREATE TABLE DON_HANG_CHI_TIET (
    MADON  INT NOT NULL,
    MADOAN INT NOT NULL,
    SOLUONG INT NOT NULL CHECK (SOLUONG > 0),
    GIATIEN DECIMAL(18,2) NOT NULL, -- giá tại thời điểm bán
    PRIMARY KEY (MADON, MADOAN),
    CONSTRAINT FK_DHCT_DON  FOREIGN KEY (MADON)  REFERENCES DON_HANG_DOAN (MADON),
    CONSTRAINT FK_DHCT_DOAN FOREIGN KEY (MADOAN) REFERENCES DOAN (MADOAN)
);
GO

/**************************************************
 * Lịch sử bán vé (qua quầy)
 **************************************************/
CREATE TABLE LICHSUBAN_VE (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MAVE   INT NOT NULL,
    MAQUAY INT NULL,
    MANV   INT NULL,
    THOIGIAN DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_LSB_VE    FOREIGN KEY (MAVE)   REFERENCES VE (MAVE),
    CONSTRAINT FK_LSB_QUAY  FOREIGN KEY (MAQUAY) REFERENCES QUAY (MAQUAY),
    CONSTRAINT FK_LSB_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)
);
GO

/**************************************************
 * Indexes đề xuất
 **************************************************/
CREATE INDEX IDX_SUATCHIEU_PHIM  ON SUATCHIEU (MAPHIM);
CREATE INDEX IDX_SUATCHIEU_PHONG ON SUATCHIEU (MAPHONG);
CREATE INDEX IDX_VE_MAKH         ON VE (MAKH);
CREATE INDEX IDX_VE_MANV         ON VE (MANV);
GO

/**************************************************
 * Ghi chú:
 * - Thứ tự tạo đã đảm bảo bảng cha trước bảng con.
 * - Tên mọi CONSTRAINT/INDEX là duy nhất trong DB.
 * - Dùng filtered unique index cho EMAIL để cho phép nhiều NULL.
 * - Các PK dùng IDENTITY(1,1) để tiện insert.
 **************************************************/
