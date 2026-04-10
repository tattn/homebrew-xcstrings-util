class XcstringsUtil < Formula
  desc "Agent-friendly CLI for Xcode string catalogs"
  homepage "https://github.com/tattn/xcstrings-util"
  version "0.0.2"


  on_macos do
    on_arm do
      url "https://github.com/tattn/xcstrings-util/releases/download/0.0.2/xcstrings-util-0.0.2-macos-arm64.tar.gz"
      sha256 "d66a65b3764bc5e1d3760ac491cc2ca7b6414854653ccfe50e79a5a81d4da5db"
    end

    on_intel do
      url "https://github.com/tattn/xcstrings-util/releases/download/0.0.2/xcstrings-util-0.0.2-macos-x86_64.tar.gz"
      sha256 "c2c2b41eff08e0a4ae5e5ddb8f82922fa98e892e8f27271a2458dae0fb868bcc"
    end
  end

  def install
    bin.install "xcstrings-util"
  end

  test do
    sample = testpath/"Sample.xcstrings"
    sample.write <<~JSON
      {
        "sourceLanguage" : "en",
        "strings" : {
          "title" : {
            "extractionState" : "manual",
            "localizations" : {
              "en" : {
                "stringUnit" : {
                  "state" : "translated",
                  "value" : "Title"
                }
              }
            }
          }
        },
        "version" : "1.0"
      }
    JSON

    output = shell_output("#{bin}/xcstrings-util locales #{sample} --json")
    assert_match "\"sourceLanguage\" : \"en\"", output
    assert_match "\"locales\" : [", output
    assert_match "\"en\"", output
  end
end
