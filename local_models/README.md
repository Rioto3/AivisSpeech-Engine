# local_models ディレクトリについて

このフォルダは、フォーク版 **AivisSpeech-Engine** における  
ローカル専用のモデルおよびログ格納領域です。  
Git管理の対象外として運用してください。

---

## 📘 概要

このディレクトリでは、  
AivisSpeech エンジンが利用する独自モデルファイル（`.aivmx`）を管理します。  
実ファイルを直接配置しても、シンボリックリンクで外部を参照しても構いません。

---

## 📁 構成

```

local_models/
├── README.md          ← この説明ファイル
└── Models/            ← モデル格納ディレクトリ
├── example_model.aivmx
└── external_model.aivmx -> /path/to/shared/models/external_model.aivmx

````

---

## ⚙️ Docker ビルドとの関係

`Dockerfile.custom` はこの構成を前提としています。  
ビルド時に `local_models/Models/` 以下のファイルを  
コンテナ内 `/home/user/.local/share/AivisSpeech-Engine-Dev/Models/` にコピーします。

```bash
docker build -f Dockerfile.custom -t aivis-engine-custom .
````

---

## 🧩 運用ルール

* このフォルダは **リポジトリ外部依存を明示するための領域** です
* `.gitignore` に `local_models/` を登録し、バージョン管理から除外してください
* シンボリックリンクを使う場合は、リンク先がビルド環境で有効であることを確認してください
* モデルファイルにはライセンス条件がある場合があるため、再配布には注意してください

---

## 🧱 参考

* コピー先（コンテナ内）
  `/home/user/.local/share/AivisSpeech-Engine-Dev/Models/`

* ログ出力先（自動生成）
  `/home/user/.local/share/AivisSpeech-Engine-Dev/Logs/`
