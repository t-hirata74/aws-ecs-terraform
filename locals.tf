# locals：ローカル変数。プライベートな変数で外部から変更はできない。
locals {
  name   = replace(basename(path.cwd), "_", "-") # カレントディレクトリの名前
  region = "ap-northeast-1"                      # 東京リージョン
  app    = "go-simple-server"                    # デプロイするアプリの名前
}