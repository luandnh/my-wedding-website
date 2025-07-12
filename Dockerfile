# GIAI ĐOẠN 1: Xây dựng ứng dụng Astro
# Sử dụng một image Node.js gọn nhẹ làm môi trường build
FROM node:20-alpine AS builder

# Thiết lập thư mục làm việc bên trong container
WORKDIR /app

# Sao chép các tệp quản lý package vào thư mục làm việc
# Điều này giúp tận dụng cache của Docker, chỉ cài lại khi package thay đổi
COPY package*.json ./

# Cài đặt các dependencies của dự án
# 'npm ci' được khuyên dùng cho môi trường CI/CD để đảm bảo cài đặt nhất quán
RUN npm ci

# Sao chép toàn bộ mã nguồn của dự án vào container
COPY . .

# Chạy lệnh build của Astro
# Kết quả sẽ được tạo ra trong thư mục /app/dist/
RUN npm run build

# GIAI ĐOẠN 2: Phục vụ ứng dụng bằng Nginx
# Sử dụng một image Nginx gọn nhẹ và ổn định
FROM nginx:stable-alpine

# Sao chép các tệp tĩnh đã được build từ giai đoạn 'builder'
# vào thư mục mặc định của Nginx để phục vụ web
COPY --from=builder /app/dist /usr/share/nginx/html

# Sao chép tệp cấu hình Nginx tùy chỉnh
# Tệp này giúp xử lý routing cho các ứng dụng trang đơn (SPA)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Mở cổng 80 để cho phép truy cập từ bên ngoài
EXPOSE 80

# Lệnh để khởi động Nginx ở chế độ foreground khi container chạy
CMD ["nginx", "-g", "daemon off;"]
