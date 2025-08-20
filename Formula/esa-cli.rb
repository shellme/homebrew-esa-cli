class EsaCli < Formula
  desc "CLI tool for managing esa.io articles"
  homepage "https://github.com/shellme/esa-cli"
  license "MIT"
  version "0.2.8"
  
  if Hardware::CPU.arm?
    url "https://github.com/shellme/esa-cli/releases/download/v#{version}/esa-cli_#{version}_darwin_arm64.tar.gz"
    sha256 "585f7a6c6df6a7ee57eeb28386ccb25752a5a509e08cc90903664a6115f1cdcf"
  else
    url "https://github.com/shellme/esa-cli/releases/download/v#{version}/esa-cli_#{version}_darwin_amd64.tar.gz"
    sha256 "2a97f51b5fe48d0de499b14299346f748283d7876a4a533213c1c4aa01a03e82"
  end

  depends_on "go" => [">=1.16", :build]

  def install
    bin.install "esa-cli" => "esa-cli"

    # 設定ファイルのテンプレートを作成（既存ファイルがある場合は上書きしない）
    (etc/"esa-cli").mkpath
    config_template = etc/"esa-cli/config.template"
    unless config_template.exist?
      config_template.write <<~EOS
        {
          "team_name": "your-team-name",
          "access_token": ""
        }
      EOS
    end
  end

  def caveats
    <<~EOS
      �� esa-cli がインストールされました！

      📋 次のステップ:
      1. esa-cli setup で初期設定
      2. esa-cli list で記事一覧を確認
      3. esa-cli fetch 123 で記事をダウンロード

      💡 詳しい使い方: https://github.com/shellme/esa-cli
      �� サポート: GitHub Issues
    EOS
  end

  test do
    system "#{bin}/esa-cli", "version"
  end
end
