# Arsify Core Fix — The Missing Layer

SKP menyimpan PROMPT senator, bukan insight. Package ini fix itu.

## Deploy
```bash
bash DEPLOY-CORE-FIX.sh
```

## 3 File Kritis
- senator-execution.py  → parse LLM output → tulis INSIGHT ke SKP
- skp-cleaner.py        → hapus 421 junk entries  
- senator-cycle-v5.sh   → pakai execution.py, bukan inline Python
