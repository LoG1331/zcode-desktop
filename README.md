# zcode-desktop

Cài và điều khiển **ZCode desktop** (bản chính thức của Z.ai) trên Linux — không cần sudo, không cần `libfuse2`, tải thẳng từ CDN.

Phần này chỉ là lớp bọc quanh bản phát hành chính thức. Không chứa mã nguồn ZCode.

## Vì sao cần repo này

AppImage chính thức không chạy được trên distro thiếu `libfuse2` (Arch/CachyOS mặc định thiếu). Cài `fuse2` thì được nhưng cần sudo và kéo thêm package. Repo này **extract** AppImage ra thư mục thường rồi tạo wrapper, nên:

- không cần sudo
- không cần FUSE
- cập nhật bằng cách chạy lại một lệnh
- có sẵn script lấy link **phone remote** của ZCode

## Cài đặt

```bash
git clone <repo-url> ~/Projects/zcode-desktop
cd ~/Projects/zcode-desktop
./install.sh
```

`install.sh` sẽ thêm `bin/` vào `PATH` (qua `~/.local/bin`) và cài ZCode bản mới nhất vào `~/Applications/ZCode-<version>`.

Sau đó:

```bash
zcode           # chạy app
zcode-remote    # lấy link điều khiển từ điện thoại
```

## Cập nhật

```bash
zcode-install              # tải và cài bản mới nhất
zcode-install --check      # chỉ xem version mới nhất
zcode-install --force      # cài lại cùng version
zcode-install --version 3.16.3   # ghim version
```

Bản cũ trong `~/Applications/` được giữ nguyên; wrapper `~/.local/bin/zcode` chuyển sang bản mới.

## Phone remote

```bash
zcode-remote            # in link https://zcode.z.ai/remote/v4?...&sid=...&mid=...
zcode-remote --qr       # lưu ảnh QR ra /tmp/zcode-qr.png
zcode-remote --open     # in link rồi mở browser
zcode-remote --stop     # tắt chia sẻ
zcode-remote --restart  # khởi động lại app kèm remote debugging
```

Script bật Chrome DevTools Protocol (`--remote-debugging-port=9222`), mở dialog *Mobile remote control*, đọc QR rồi decode bằng `zbarimg`. Cần `zbarimg` (gói `zbar`); nếu thiếu, script vẫn lưu QR để quét tay.

Link remote đổi theo session/workspace — chạy lại `zcode-remote` khi cần link mới.

## Yêu cầu

| Thành phần | Ghi chú |
|---|---|
| `curl`, `openssl` | tải và verify sha512 |
| `zbar` (`zbarimg`) | chỉ cần cho `zcode-remote` |
| Node.js 22+ | chỉ cần cho `zcode-remote` (dùng WebSocket có sẵn) |
| Wayland hoặc X11 | script dùng `WAYLAND_DISPLAY`; sửa `ZCODE_*` env nếu khác |

Không cần `libfuse2`, không cần sudo (trừ khi chọn `--deb`/`--rpm`).

## Cấu trúc

```
install.sh            # cài lần đầu (gọi zcode-install + link PATH)
bin/zcode-install     # tải/extract/verify/cập nhật từ CDN chính thức
bin/zcode-remote      # lấy link + QR phone remote qua CDP
```

## Biến môi trường

| Biến | Mặc định |
|---|---|
| `ZCODE_CDN` | `https://cdn-zcode.z.ai/zcode/electron/releases` |
| `ZCODE_INSTALL_DIR` | `~/Applications` |
| `ZCODE_BIN_DIR` | `~/.local/bin` |
| `ZCODE_CDP_PORT` | `9222` |
| `ZCODE_QR_FILE` | `/tmp/zcode-qr.png` |
| `ZCODE_REMOTE_NO_AUTOSTART` | `0` — đặt `1` để không tự restart app |

## Gỡ

```bash
rm -rf ~/Applications/ZCode-*
rm -f ~/.local/bin/zcode ~/.local/bin/zcode-install ~/.local/bin/zcode-remote
rm -f ~/.local/share/applications/zcode.desktop ~/.local/share/icons/hicolor/512x512/apps/zcode.png
```

Dữ liệu ứng dụng nằm ở `~/.zcode` — xoá riêng nếu muốn sạch hoàn toàn.
