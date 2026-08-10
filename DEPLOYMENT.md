# Thông Tin Deploy - Checkpoint 5

## Thông Tin Học Viên

| Mục | Nội dung |
|-----|----------|
| Họ và tên | Nguyễn Tuấn Anh |
| Mã học viên | 2A202601775 |
| Repo | https://github.com/ngtanh1112/DAY12-2A202601775-NguyenTuanAnh |

## Service

| Mục | Nội dung |
|-----|----------|
| Public URL | https://day12-agent-m7oz.onrender.com |
| Platform | Render |
| Ngày deploy | 2026-08-10 |

## Biến Môi Trường Đã Set Trên Cloud

Chỉ ghi tên biến và nguồn giá trị, không ghi giá trị secret:

| Biến | Đã set | Ghi chú |
|------|--------|---------|
| `PORT` | Có | Render tự gán cho web service |
| `AGENT_API_KEY` | Có | Đặt trong Render dashboard, không nằm trong repo |
| `REDIS_URL` | Có | Render Key Value/Valkey service `day12-redis` qua `render.yaml` |
| `RATE_LIMIT_PER_MINUTE` | Có | 10 |
| `MONTHLY_BUDGET_USD` | Có | 10.0 |
| `LOG_LEVEL` | Có | INFO |

## Lệnh Kiểm Tra

```bash
curl -i https://day12-agent-m7oz.onrender.com/health
curl -i https://day12-agent-m7oz.onrender.com/ready
curl -i -X POST https://day12-agent-m7oz.onrender.com/ask \
  -H "Content-Type: application/json" \
  -d '{"question":"Hello"}'
```

## Kết Quả Chạy Thật

```text
GET /health -> 200 {"status":"ok","service":"day12-agent","version":"1.0.0"}
GET /ready  -> 200 {"status":"ready","redis":true}
POST /ask without X-API-Key -> 401 {"detail":"invalid or missing API key"}
POST /ask with X-API-Key -> 200, response có answer, user_id, history_length, cost_usd, tokens
```

## Ảnh Chụp Màn Hình

Ảnh minh chứng nên đặt trong thư mục `screenshots/`, ví dụ:

- dashboard Render của service `day12-agent`
- kết quả mở `/health` hoặc `/ready` trên public URL
- terminal chạy `pytest tests/test_cp5.py -v`
