# Thong Tin Deploy - Checkpoint 5

## Thong Tin Hoc Vien

| Muc | Noi dung |
|-----|----------|
| Ho va ten | Nguyen Tuan Anh |
| Ma hoc vien / mã học viên | 2A202601775 |
| Repo | https://github.com/ngtanh1112/DAY12-2A202601775-NguyenTuanAnh |

## Service

| Muc | Noi dung |
|-----|----------|
| Public URL | Chua co public cloud URL; dang dung local fallback tai `http://localhost:8000` |
| Platform | Local fallback bang Docker Compose; du kien deploy Render hoac Railway |
| Ngay deploy | 2026-08-10 |

## Bien Moi Truong Da Set Tren Cloud

Ghi ten bien va nguon gia tri, khong ghi gia tri secret:

| Bien | Da set | Ghi chu |
|------|--------|---------|
| `PORT` | co | Platform tu gan khi deploy; local compose dung 8000 |
| `AGENT_API_KEY` | co | Dat trong `.env` local va se dat trong dashboard cloud, khong nam trong repo |
| `REDIS_URL` | co | Local: Redis service trong Docker Compose; cloud: Redis add-on cua platform |
| `RATE_LIMIT_PER_MINUTE` | co | 10 |
| `MONTHLY_BUDGET_USD` | co | 10.0 |
| `LOG_LEVEL` | co | INFO |

## Lenh Kiem Tra

```bash
curl -i http://localhost:8000/health
curl -i http://localhost:8000/ready
curl -i -X POST http://localhost:8000/ask \
  -H "Content-Type: application/json" \
  -d '{"question":"Hello"}'
```

## Ket Qua Chay That

```text
GET /health -> 200 {"status":"ok","service":"day12-agent","version":"1.0.0"}
GET /ready  -> 200 {"status":"ready","redis":true}
POST /ask without X-API-Key -> 401
POST /ask with X-API-Key -> 200, response co answer, user_id, history_length, cost_usd, tokens
```

## Anh Chup Man Hinh

Dat anh minh chung local fallback trong thu muc `screenshots/`.

## Neu Dung Phuong An Du Phong

Dang dung phuong an du phong vi chua co public URL tu Railway/Render trong thoi diem chay test local.
Local stack da chay bang Docker Compose voi `agent` va `redis` healthy.
