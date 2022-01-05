class HazelcastAT51Snapshot < Formula
    desc "Tool to run Hazelcast IMDG member instances locally"
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://oss.sonatype.org/content/repositories/snapshots/com/hazelcast/hazelcast-distribution/5.1-SNAPSHOT/hazelcast-distribution-5.1-20220105.224138-213.tar.gz"
    sha256 "6c230fc484ab9bf8800a328a42d83ea4588f6181171c81c5dd2d71087c5d94e1"
  
    bottle :unneeded
  
    depends_on "openjdk" => :recommended
  
    def install
      libexec.install Dir["*"]
      Dir["#{libexec}/bin/hz*"].each do |path|
        executable_name = File.basename(path)
        if executable_name.end_with? ".bat"
          next
        end
        (bin/executable_name).write_env_script libexec/"bin/#{executable_name}", Language::Java.overridable_java_home_env
      end
      prefix.install_metafiles
      inreplace libexec/"bin/download/hazelcast-download.properties", "hazelcastDownloadId=CLI", "hazelcastDownloadId=CLI_BREW"
    end
  
    def post_install
      exec "hz"
    end
  
  end
  