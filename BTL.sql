use master
go
drop database BTL
go
create database BTL
go
use BTL

-- Bảng Vai Trò
CREATE TABLE VaiTro( 
	MaVT INT NOT NULL PRIMARY KEY,	
	TenVT NVARCHAR(255)
);

-- Bảng Người Dùng
CREATE TABLE NguoiDung (
	ID INT NOT NULL PRIMARY KEY,
	DisplayName NVARCHAR(max),
	TaiKhoan VARCHAR(255),
	MatKhau VARCHAR(255),
	SDT VARCHAR(255),
	MaVT INT,
	FOREIGN KEY (MaVT) REFERENCES VaiTro(MaVT) ON DELETE SET NULL
);

-- Bảng Huyện
CREATE TABLE Huyen (
    MaHuyen INT NOT NULL PRIMARY KEY,
    TenHuyen NVARCHAR(255)
);

-- Bảng Xã
CREATE TABLE Xa (
    MaXa INT NOT NULL PRIMARY KEY,
    TenXa NVARCHAR(255),
    DienTich FLOAT,
    MaHuyen INT,
    FOREIGN KEY (MaHuyen) REFERENCES Huyen(MaHuyen) ON DELETE SET NULL
);


-- Bảng QuyHoach
CREATE TABLE QuyHoach (
    MaQH INT NOT NULL PRIMARY KEY,
    LoaiQH NVARCHAR(255),
    QuyMo NVARCHAR(255),
    ThoiGian DATETIME,
    ChuKy INT,
    NguonVon NVARCHAR(255),
    MaXa INT,
    FOREIGN KEY (MaXa) REFERENCES Xa(MaXa) ON DELETE SET NULL
);

-- Bảng Báo Cáo Quy Hoạch
CREATE TABLE BaoCaoQH (
    MaBCQH INT NOT NULL PRIMARY KEY,                 
    TenBCQH NVARCHAR(255),                 
    NgayBCQH DATETIME,                     
    TienDoQH NVARCHAR(255),                
    VanDePhatSinh NVARCHAR(MAX),                    
    GiaiPhap NVARCHAR(MAX),                         
    MaQH INT,                          
    FOREIGN KEY (MaQH) REFERENCES QuyHoach(MaQH) ON DELETE SET NULL
);

-- Bảng Công trình
CREATE TABLE CongTrinh (
    MaCT INT NOT NULL PRIMARY KEY,
    TenCT NVARCHAR(255),
    TienDoCT NVARCHAR(50),
    ToaDoCT NVARCHAR(50),
	MaQH INT,
	FOREIGN KEY (MaQH) REFERENCES QuyHoach(MaQH) ON DELETE SET NULL
);

-- Bảng Thống kê
CREATE TABLE ThongKe (
    MaTK INT NOT NULL PRIMARY KEY,
    LoaiTK NVARCHAR(255) ,
    ThoiGianTK DATETIME,
    MaXa INT,
    FOREIGN KEY (MaXa) REFERENCES Xa(MaXa) ON DELETE SET NULL
);

-- Bảng Chỉ số Nước Sạch
CREATE TABLE ChiSoNuocSach (
    MaCS INT NOT NULL PRIMARY KEY,
    TenCS NVARCHAR(255),
    GiaTri FLOAT,
    MaTK INT,
    FOREIGN KEY (MaTK) REFERENCES ThongKe(MaTK) ON DELETE SET NULL
);


-- Bảng Văn bản Pháp luật
CREATE TABLE VanBanPL (
    MaVB INT NOT NULL PRIMARY KEY,
    TieuDe NVARCHAR(255),
    NgayBanHanh DATETIME,
    CoQuanBH NVARCHAR(255),
    LoaiVB NVARCHAR(255),
    TrangThai NVARCHAR(50),
    MaXa INT,
    FOREIGN KEY (MaXa) REFERENCES Xa(MaXa) ON DELETE CASCADE
);

-- Dữ liệu bảng VaiTro
INSERT INTO VaiTro(MaVT, TenVT)
VALUES
(1, N'Admin'),
(2, N'CBNV');

-- Dữ liệu bảng NguoiDung
INSERT INTO NguoiDung(ID, DisplayName, TaiKhoan, MatKhau, SDT, MaVT) 
VALUES
(1, N'Quản trị hệ thống', N'Admin', N'abcdefgh', '0782 755 332', 1),
(2, N'Cán bộ nghiệp vụ 1', N'CBNV', N'abc123jkl', '0860 140 879', 2),
(3, N'Cán bộ nghiệp vụ 2', N'CBNV', N'abc123opq', '0792 287 149', 2);

-- Dữ liệu bảng Huyen
INSERT INTO Huyen(MaHuyen, TenHuyen) 
VALUES 
(1, N'Huyện Ba Vì'),
(2, N'Huyện Thanh Oai'),
(3, N'Huyện Mê Linh'),
(4, N'Huyện Đông Anh'),
(5, N'Huyện Gia Lâm'),
(6, N'Huyện Sóc Sơn'),
(7, N'Huyện Thanh Trì'),
(8, N'Huyện Thạch Thất'),
(9, N'Huyện Hoài Đức'),
(10, N'Huyện Quốc Oai'),
(11, N'Huyện Chương Mỹ'),
(12, N'Huyện Đan Phượng');

-- Dữ liệu bảng Xa
INSERT INTO Xa(MaXa, TenXa, DienTich, MaHuyen)
VALUES 
(1, N'Xã Tản Lĩnh', 17.8, 1), -- Huyện Ba Vì
(2, N'Xã Thuần Mỹ', 18.5, 1),
(3, N'Xã Kim An', 14.3, 2), -- Huyện Thanh Oai
(4, N'Xã Phương Trung', 15.7, 2),
(5, N'Xã Tiến Thịnh', 16.9, 3), -- Huyện Mê Linh
(6, N'Xã Tam Đồng', 12.5, 3),
(7, N'Xã Hải Bối', 13.2, 4), -- Huyện Đông Anh
(8, N'Xã Đông Hội', 14.6, 4),
(9, N'Xã Yên Viên', 11.4, 5), -- Huyện Gia Lâm
(10, N'Xã Thiên Đức', 10.8, 5),
(11, N'Xã Phù Linh', 20.0, 6), -- Huyện Sóc Sơn
(12, N'Xã Minh Phú', 22.3, 6),
(13, N'Xã Tả Thanh Oai', 14.5, 7), -- Huyện Thanh Trì
(14, N'Xã Vĩnh Quỳnh', 13.0, 7),
(15, N'Xã Đại Đồng', 18.3, 8), -- Huyện Thạch Thất
(16, N'Xã Hương Ngải', 17.2, 8),
(17, N'Xã An Khánh', 21.4, 9), -- Huyện Hoài Đức
(18, N'Xã Vân Côn', 20.0, 9),
(19, N'Xã Đồng Quang', 19.5, 10), -- Huyện Quốc Oai
(20, N'Xã Phú Cát', 18.1, 10),
(21, N'Xã Ngọc Hòa', 22.3, 11), -- Huyện Chương Mỹ
(22, N'Xã Đông Sơn', 24.0, 11),
(23, N'Xã Tân Hội', 15.5, 12), -- Huyện Đan Phượng
(24, N'Xã Hạ Mỗ', 16.8, 12);

-- Dữ liệu bảng QuyHoach
INSERT INTO QuyHoach(MaQH, LoaiQH, QuyMo, ThoiGian, ChuKy, NguonVon, MaXa)
VALUES 
(1, N'Xây dựng hệ thống thu gom rác thải', N'Lớn', '2025-02-01', 10, N'Ngân sách nhà nước', 4), -- Xã Phương Trung
(2, N'Cải tạo hệ thống thoát nước sinh hoạt', N'Nhỏ', '2025-03-10', 5, N'Quỹ bảo vệ môi trường', 7), -- Xã Hải Bối
(3, N'Xử lý chất thải chăn nuôi', N'Vừa', '2024-01-15', 3, N'Tài trợ quốc tế', 15), -- Xã Đại Đồng
(4, N'Xây dựng khu xử lý rác thải tập trung', N'Nhỏ', '2024-11-20', 4, N'Doanh nghiệp tư nhân', 22), -- Xã Đông Sơn
(5, N'Phát triển hệ thống nước sạch', N'Lớn', '2024-08-30', 7, N'Ngân sách nhà nước', 1), -- Xã Tản Lĩnh
(6, N'Cải tạo môi trường ao, hồ', N'Lớn', '2024-09-12', 15, N'Tài trợ quốc tế', 3), -- Xã Kim An
(7, N'Xây dựng nhà vệ sinh công cộng', N'Vừa', '2024-05-10', 6, N'Tài trợ từ tổ chức quốc tế', 11), -- Xã Phù Linh
(8, N'Quản lý chất thải sinh hoạt', N'Lớn', '2024-06-15', 10, N'Ngân sách nhà nước', 20), -- Xã Phú Cát
(9, N'Xử lý nước thải tập trung', N'Lớn', '2024-12-01', 12, N'Ngân sách thành phố', 18), -- Xã Vân Côn
(10, N'Trồng cây xanh ven kênh mương', N'Nhỏ', '2024-03-15', 4, N'Huy động vốn cộng đồng', 6), -- Xã Tam Đồng
(11, N'Bảo vệ nguồn nước ngầm', N'Vừa', '2024-10-01', 8, N'Tài trợ quốc tế', 9), -- Xã Yên Viên
(12, N'Xây dựng trạm tái chế rác thải', N'Vừa', '2024-02-20', 5, N'Doanh nghiệp tư nhân', 14), -- Xã Vĩnh Quỳnh
(13, N'Xây dựng hệ thống bãi rác hợp vệ sinh', N'Lớn', '2024-06-05', 15, N'Ngân sách nhà nước', 2), -- Xã Thuần Mỹ
(14, N'Giám sát chất lượng nước sinh hoạt', N'Nhỏ', '2024-09-01', 3, N'Quỹ bảo vệ môi trường', 23), -- Xã Tân Hội
(15, N'Xử lý nước thải công nghiệp nhỏ', N'Vừa', '2024-08-12', 7, N'Tài trợ quốc tế', 13), -- Xã Tả Thanh Oai
(16, N'Xây dựng hệ thống giám sát ô nhiễm môi trường', N'Lớn', '2024-04-18', 10, N'Ngân sách nhà nước', 10), -- Xã Đồng Quang
(17, N'Giảm thiểu rác thải nhựa', N'Nhỏ', '2024-02-14', 3, N'Hợp tác quốc tế', 5); -- Xã An Khánh

-- Dữ liệu bảng BaoCaoQH
INSERT INTO BaoCaoQH(MaBCQH, TenBCQH, NgayBCQH, TienDoQH, VanDePhatSinh, GiaiPhap, MaQH)
VALUES 
(1, N'Báo cáo Xây dựng hệ thống thu gom rác thải', '2025-05-01', N'Đang thực hiện', N'Kinh phí chậm cấp', N'Tăng cường huy động vốn xã hội hóa', 1),
(2, N'Báo cáo Cải tạo hệ thống thoát nước sinh hoạt', '2025-07-01', N'Hoàn thành', N'Không', N'Không', 2),
(3, N'Báo cáo Xử lý chất thải chăn nuôi', '2025-10-15', N'Đang thực hiện', N'Thiếu nhân sự kỹ thuật', N'Thuê thêm chuyên gia tư vấn', 3),
(4, N'Báo cáo Xây dựng khu xử lý rác thải tập trung', '2024-11-10', N'Hoàn thành', N'Không', N'Không', 4),
(5, N'Báo cáo Phát triển hệ thống nước sạch', '2025-01-05', N'Đang thực hiện', N'Vấn đề kỹ thuật', N'Tăng cường kiểm tra hệ thống', 5),
(6, N'Báo cáo Cải tạo môi trường ao, hồ', '2025-02-12', N'Hoàn thành', N'Không', N'Không', 6),
(7, N'Báo cáo Xây dựng nhà vệ sinh công cộng', '2025-03-15', N'Đang thực hiện', N'Kinh phí chưa đủ', N'Xin bổ sung ngân sách', 7),
(8, N'Báo cáo Quản lý chất thải sinh hoạt', '2025-04-20', N'Hoàn thành', N'Không', N'Không', 8),
(9, N'Báo cáo Xử lý nước thải tập trung', '2025-05-25', N'Đang thực hiện', N'Công nghệ chưa phù hợp', N'Nghiên cứu giải pháp thay thế', 9),
(10, N'Báo cáo Trồng cây xanh ven kênh mương', '2025-06-30', N'Hoàn thành', N'Không', N'Không', 10),
(11, N'Báo cáo Bảo vệ nguồn nước ngầm', '2025-07-15', N'Đang thực hiện', N'Vấn đề bảo vệ môi trường', N'Tăng cường tuyên truyền bảo vệ nguồn nước', 11),
(12, N'Báo cáo Xây dựng trạm tái chế rác thải', '2025-08-10', N'Hoàn thành', N'Không', N'Không', 12),
(13, N'Báo cáo Xây dựng hệ thống bãi rác hợp vệ sinh', '2025-09-05', N'Đang thực hiện', N'Kinh phí còn thiếu', N'Tìm kiếm nguồn tài trợ', 13),
(14, N'Báo cáo Giám sát chất lượng nước sinh hoạt', '2025-10-01', N'Hoàn thành', N'Không', N'Không', 14),
(15, N'Báo cáo Xử lý nước thải công nghiệp nhỏ', '2025-11-10', N'Đang thực hiện', N'Vấn đề công nghệ', N'Tìm kiếm giải pháp công nghệ mới', 15),
(16, N'Báo cáo Xây dựng hệ thống giám sát ô nhiễm môi trường', '2025-12-01', N'Hoàn thành', N'Không', N'Không', 16),
(17, N'Báo cáo Giảm thiểu rác thải nhựa', '2026-01-15', N'Đang thực hiện', N'Khó khăn trong việc vận động cộng đồng', N'Tổ chức các chiến dịch nâng cao nhận thức', 17);

-- Dữ liệu bảng CongTrinh
INSERT INTO CongTrinh(MaCT, TenCT, TienDoCT, ToaDoCT, MaQH)
VALUES
(1, N'Trạm xử lý rác thải Hy Vọng', N'Hoạt động', N'Gần trung tâm xã', 1),
(2, N'Trạm xử lý rác thải 1', N'Sửa chữa', N'Phía tây khu vực', 1),
(3, N'Trạm xử lý rác thải Hoa loa kèn', N'Đang triển khai', N'Trên con đường chính', 1),
(4, N'Hệ thống thu gom rác', N'Hoạt động', N'Trong khu vực lân cận', 1),
(5, N'Hệ thống thu gom rác', N'Hoạt động', N'Đầu đường lớn', 1),
(6, N'Trạm cấp nước Kiêu Kị 1', N'Sửa chữa', N'Gần trường học', 2),
(7, N'Trạm cấp nước Kiêu Kị 2', N'Đang triển khai', N'Phía đông khu dân cư', 2),
(8, N'Trạm cấp nước Hoàng Phước', N'Hoạt động', N'Khu vực gần công viên', 2),
(9, N'Trạm xử lý rác thải Hy Vọng', N'Hoạt động', N'Phía tây xã', 3),
(10, N'Trạm xử lý rác thải', N'Sửa chữa', N'Gần chợ Xã', 3),
(11, N'Trạm xử lý nước thải Hoàng Phước', N'Đang triển khai', N'Trên con đường chính', 3),
(12, N'Bãi rác sinh hoạt', N'Hoạt động', N'Khu vực gần ao hồ', 4),
(13, N'Bãi rác sinh hoạt', N'Sửa chữa', N'Phía tây khu dân cư', 4),
(14, N'Trạm xử lý rác thải Hoa loa kèn', N'Đang triển khai', N'Gần khu công nghiệp', 4),
(15, N'Trạm cấp nước Hao', N'Hoạt động', N'Gần khu vực trường học', 5),
(16, N'Trạm cấp nước Hoàng Phước', N'Sửa chữa', N'Khu vực ven sông', 5),
(17, N'Trạm cấp nước Phong Phú', N'Đang triển khai', N'Khu dân cư ngoại thành', 5),
(18, N'Hệ thống thoát nước sinh hoạt', N'Hoạt động', N'Phía bắc khu vực xã', 6),
(19, N'Hệ thống thoát nước sinh hoạt', N'Sửa chữa', N'Trên con đường trung tâm', 6),
(20, N'Hệ thống thoát nước sinh hoạt', N'Đang triển khai', N'Gần cổng chợ', 6),
(21, N'Nhà vệ sinh công cộng', N'Hoạt động', N'Gần hồ lớn', 7),
(22, N'Nhà vệ sinh công cộng', N'Sửa chữa', N'Gần bờ sông', 7),
(23, N'Nhà vệ sinh công cộng', N'Đang triển khai', N'Khu vực lân cận trung tâm', 7),
(24, N'Trạm xử lý nước thải Phú Hải', N'Hoạt động', N'Phía nam khu dân cư', 8),
(25, N'Trạm xử lý nước thải Hy Vọng', N'Sửa chữa', N'Gần trường học', 8),
(26, N'Trạm xử lý nước thải Mắm tôm', N'Đang triển khai', N'Khu vực cạnh chợ', 8),
(27, N'Trạm xử lý nước thải Mần', N'Hoạt động', N'Gần khu công nghiệp', 9),
(28, N'Trạm xử lý nước thải Phú Nhĩ', N'Sửa chữa', N'Gần đường cao tốc', 9),
(29, N'Trạm xử lý nước thải Phú Hải', N'Đang triển khai', N'Phía đông khu công nghiệp', 9),
(30, N'Trồng cây xanh', N'Hoạt động', N'Khu vực ngoài thành phố', 10),
(31, N'Trồng cây xanh', N'Sửa chữa', N'Phía bắc khu dân cư', 10),
(32, N'Trồng cây xanh', N'Đang triển khai', N'Khu vực gần sông', 10),
(33, N'Hệ thống thoát nước thải', N'Hoạt động', N'Gần công viên trung tâm', 11),
(34, N'Hệ thống thoát nước thải', N'Sửa chữa', N'Gần khu dân cư', 11),
(35, N'Hệ thống thoát nước thải', N'Đang triển khai', N'Phía đông xã', 11),
(36, N'Trạm xử lý rác thải 1', N'Hoạt động', N'Gần công viên lớn', 12),
(37, N'Trạm xử lý rác thải Hoài Đất', N'Sửa chữa', N'Phía bắc khu dân cư', 12),
(38, N'Trạm xử lý rác thải Rạ', N'Đang triển khai', N'Gần trung tâm thương mại', 12),
(39, N'Hệ thống thu gom rác thải', N'Hoạt động', N'Phía nam xã', 13),
(40, N'Hệ thống thu gom rác thải', N'Sửa chữa', N'Khu vực trường học', 13),
(41, N'Hệ thống thu gom rác thải', N'Đang triển khai', N'Khu vực chợ trung tâm', 13),
(42, N'Trạm giám sát chất lượng nước Thuỵ', N'Hoạt động', N'Khu vực gần bãi biển', 14),
(43, N'Trạm giám sát chất lượng nước Thuỵ 2', N'Sửa chữa', N'Phía tây khu công nghiệp', 14),
(44, N'Trạm giám sát chất lượng nước Thuỵ 3', N'Đang triển khai', N'Gần bờ sông', 14),
(45, N'Trạm xử lý nước thải Quang Hoa', N'Hoạt động', N'Phía đông khu dân cư', 15),
(46, N'Trạm xử lý nước thải Hò', N'Sửa chữa', N'Gần cổng trường học', 15),
(47, N'Trạm xử lý nước thải Phú Hải', N'Đang triển khai', N'Khu công nghiệp phía nam', 15),
(48, N'Trạm giám sát chất lượng nước Thuỵ', N'Hoạt động', N'Phía tây bắc xã', 16),
(49, N'Trạm giám sát chất lượng không khí Thuỵ', N'Sửa chữa', N'Gần khu phố mới', 16),
(50, N'Trạm giám sát chất lượng đất Thuỵ', N'Đang triển khai', N'Khu dân cư phía đông', 16),
(51, N'Trạm xử lý rác thải 2', N'Hoạt động', N'Gần khu vực công viên', 17),
(52, N'Trạm xử lý rác thải Rạ', N'Sửa chữa', N'Khu vực chợ ngoài thành', 17),
(53, N'Trạm xử lý rác thải 1', N'Đang triển khai', N'Gần khu dân cư', 17);

-- Dữ liệu bảng ThongKe
INSERT INTO ThongKe(MaTK, LoaiTK, ThoiGianTK, MaXa)
VALUES
(1, N'Thống kê hàng tháng', '2024-01-01', 1),
(2, N'Thống kê hàng quý', '2024-03-01', 1),
(3, N'Thống kê hàng năm', '2024-12-31', 1),
(4, N'Thống kê hàng tháng', '2024-02-02', 2),
(5, N'Thống kê hàng quý', '2024-06-01', 2),
(6, N'Thống kê hàng năm', '2024-12-31', 2),
(7, N'Thống kê hàng tháng', '2024-02-01', 3),
(8, N'Thống kê hàng quý', '2024-05-05', 3),
(9, N'Thống kê hàng năm', '2024-12-31', 3),
(10, N'Thống kê hàng tháng', '2024-04-01', 4),
(11, N'Thống kê hàng quý', '2024-09-01', 4),
(12, N'Thống kê hàng năm', '2024-12-31', 4),
(13, N'Thống kê hàng tháng', '2024-08-01', 5),
(14, N'Thống kê hàng quý', '2024-06-01', 5),
(15, N'Thống kê hàng năm', '2024-12-31', 5);

-- Dữ liệu bảng ChiSoNuocSach
INSERT INTO ChiSoNuocSach (MaCS, TenCS, GiaTri, MaTK)
VALUES 
(1, N'Chỉ số TDS', 400, 1),
(2, N'Chỉ số TDS', 322, 2),
(3, N'Chỉ số TDS', 311, 3),
(4, N'Chỉ số TDS', 253, 4),
(5, N'Chỉ số TDS', 422, 5),
(6, N'Chỉ số TDS', 365, 6),
(7, N'Chỉ số TDS', 305, 7),
(8, N'Chỉ số TDS', 235, 8),
(9, N'Chỉ số TDS', 350, 9),
(10, N'Chỉ số TDS', 330, 10),
(11, N'Chỉ số TDS', 170, 11),
(12, N'Chỉ số TDS', 150, 12),
(13, N'Chỉ số TDS', 200, 13),
(14, N'Chỉ số TDS', 230, 14),
(15, N'Chỉ số TDS', 210, 15);

-- Dữ liệu bảng VanBanPL
INSERT INTO VanBanPL(MaVB, TieuDe, NgayBanHanh, CoQuanBH, LoaiVB, TrangThai, MaXa)
VALUES
(1, N'Luật Bảo vệ Môi trường', '2024-01-01', N'Bộ Tài nguyên và Môi trường', N'Luật', N'Đang áp dụng', 1), -- Xã Tản Lĩnh
(2, N'Nghị định về Xử lý chất thải', '2024-02-10', N'Xã Thuần Mỹ', N'Nghị định', N'Đang áp dụng', 2), -- Xã Thuần Mỹ
(3, N'Thông tư Quy định về Quy hoạch môi trường', '2024-03-05', N'Bộ Xây dựng', N'Thông tư', N'Đang áp dụng', 3), -- Xã Kim An
(4, N'Quy chế về quản lý chất thải rắn', '2024-04-15', N'Bộ Môi trường', N'Quy chế', N'Đang áp dụng', 4), -- Xã Phương Trung
(5, N'Quy hoạch về Bảo vệ nguồn nước', '2024-05-10', N'Bộ Tài nguyên và Môi trường', N'Quy hoạch', N'Đang áp dụng', 5), -- Xã Tiến Thịnh
(6, N'Nghị định về Xử lý nước thải công nghiệp', '2024-06-01', N'Bộ Tài nguyên và Môi trường', N'Nghị định', N'Đang áp dụng', 6), -- Xã Tam Đồng
(7, N'Thông tư Quy định về Giám sát ô nhiễm môi trường', '2024-07-20', N'Bộ Tài nguyên và Môi trường', N'Thông tư', N'Đang áp dụng', 7), -- Xã Hải Bối
(8, N'Luật Bảo vệ Nguồn nước ngầm', '2024-08-01', N'Bộ Tài nguyên và Môi trường', N'Luật', N'Đang áp dụng', 8), -- Xã Đông Hội
(9, N'Quy chế Xử lý chất thải sinh hoạt', '2024-09-15', N'Xã Yên Viên', N'Quy chế', N'Đang áp dụng', 9), -- Xã Yên Viên
(10, N'Nghị định về Quản lý nước sạch', '2024-10-20', N'Xã Thiên Đức', N'Nghị định', N'Đang áp dụng', 10); -- Xã Thiên Đức




SELECT * FROM CongTrinh;

Select * from Xa;


