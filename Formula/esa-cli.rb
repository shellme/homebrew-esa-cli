class EsaCli < Formula
  desc "CLI tool for managing esa.io articles"
  homepage "https://github.com/shellme/esa-cli"
  license "MIT"
  version "0.2.7"
  
  if Hardware::CPU.arm?
    url "https://github.com/shellme/esa-cli/releases/download/v#{version}/esa-cli_#{version}_darwin_arm64.tar.gz"
    sha256 "3b4955c5b0bf8705fa385ec971752c6f8b64f4a81ca5acf4b62f6ac937d8afa0"
  else
    url "https://github.com/shellme/esa-cli/releases/download/v#{version}/esa-cli_#{version}_darwin_amd64.tar.gz"
    sha256 "e2de85abdfc746ff3a81354d6c7ab6b6cf9ef2f08147f38f52346031745ff15b"
  end

  depends_on "go" => [">=1.16", :build]

  def install
    bin.install "esa-cli" => "esa-cli"

    # 設定ファイルのテンプレートを作成
    (etc/"esa-cli").mkpath
    (etc/"esa-cli/config.template").write <<~EOS
      {
        "team_name": "your-team-name",
        "access_token": ""
      }
    EOS
  end

  def caveats
    <<~EOS
      🎉 esa-cli がインストールされました！

      📋 次のステップ:
      1. esa-cli setup で初期設定
      2. esa-cli list で記事一覧を確認
      3. esa-cli fetch 123 で記事をダウンロード

      💡 詳しい使い方: https://github.com/shellme/esa-cli
      🆘 サポート: GitHub Issues
    EOS
  end

  test do
    system "#{bin}/esa-cli", "version"
  end
end
