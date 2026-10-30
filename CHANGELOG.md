# Changelog

## 1.0.0

- `zcode-install`: tải AppImage chính thức từ CDN Z.ai, verify sha512 từ `latest.yml`, extract (không cần FUSE/sudo), tạo wrapper + desktop entry. Hỗ trợ `--version`, `--force`, `--check`, `--deb`, `--rpm`.
- `zcode-remote`: lấy link phone remote qua Chrome DevTools Protocol, decode QR bằng `zbarimg`. Hỗ trợ `--link`, `--qr`, `--open`, `--stop`, `--restart`; tự restart app kèm remote debugging khi cần.
- `install.sh`: link hai script trên vào `~/.local/bin`.
