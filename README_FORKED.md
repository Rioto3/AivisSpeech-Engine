# AivisSpeech-Engine (Forked Edition)

このリポジトリは [Aivis-Project/AivisSpeech-Engine](https://github.com/Aivis-Project/AivisSpeech-Engine)
をフォークして、**Spinning｜GPT System** に統合・拡張するために管理しているものです。

---

## 📘 概要

基本的な機能・構造は本家と同一です。  
本リポジトリでは、以下の目的で調整・安定化を行っています。

- `Dockerfile.custom` による独自ビルド設定  
- 独自モデル（`/models/`）の追加  
- Spinning Reels System との連携整備  
- 安定タグ（例: `stable-2026.01.21`）による再現性管理  

---

## 🧭 運用構成

| 要素 | 内容 |
|------|------|
| 本家（upstream） | [Aivis-Project/AivisSpeech-Engine](https://github.com/Aivis-Project/AivisSpeech-Engine) |
| フォーク（origin） | あなたの管理リポジトリ |
| 安定ブランチ | `main` |
| 拡張ブランチ | `custom` |
| 更新元 | `upstream/master` |

---

## 🧱 使用方法（Fork版）

### 1️⃣ ビルド
```bash
docker build -f Dockerfile.custom -t aivis-engine-custom .
````

### 2️⃣ 実行

```bash
docker run -p 10101:10101 aivis-engine-custom
```

---

## 🔄 更新ポリシー

1. 本家の最新を取得

   ```bash
   git fetch upstream
   git merge upstream/master
   ```

2. テスト後に安定タグを作成

   ```bash
   git tag stable-YYYY.MM.DD
   git push origin main --tags
   ```

3. 独自拡張は `custom` ブランチで管理

---

## 📎 参考

* Original Repository: [AivisSpeech-Engine](https://github.com/Aivis-Project/AivisSpeech-Engine)
* Fork Maintainer: @dyethesky
* Integrated System: Spinning｜GPT
