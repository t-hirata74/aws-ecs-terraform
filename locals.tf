# locals：ローカル変数。プライベートな変数で外部から変更はできない。
locals {
  name   = replace(basename(path.cwd), "_", "-")
  region = "ap-northeast-1"
  app    = "go-simple-server"
}