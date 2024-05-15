module "vpc" {
  # 下記のように記述することで、"terraform-aws-modules/vpc/aws" という Module を使うことができます。
  source = "terraform-aws-modules/vpc/aws"

  # こちらのコードで VPC の名前を設定しています。今回は、ルートディレクトリ（カレントディレクトリ）の名前にしました。
  name = local.name
  # VPC で使用するプライベートネットワークの IP アドレスの範囲は 10.0.0.0/16 とします。
  cidr = "10.0.0.0/16"

  # 二つのアベイラビリティゾーン（ap-northeast-1a と ap-northeast-1c）のそれぞれに Public サブネットと Private サブネットを用意します。
  azs             = ["${local.region}a", "${local.region}c"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  # サブネットの名前を下記のように設定しました。アベイラビリティゾーンの 1a と 1c を名前に含ませています。
  public_subnet_names  = ["Public Subnet 1a", "Public Subnet 1c"]
  private_subnet_names = ["Private Subnet 1a", "Private Subnet 1c"]

  # AWS の DNS サーバーによる名前解決が有効
  enable_dns_hostnames = true

  # VPC 内のリソースにパブリック DNS ホスト名を自動的に割り当ててくれます。
  enable_dns_support = true

  # インターネットゲートウェイは、デフォルトで生成されますが、NAT ゲートウェイを作成するためには、明示的に記述する必要があります。下記のように記述することで、各 Public サブネットに一つずつ NAT ゲートウェイが配置されます。
  enable_nat_gateway = true
}