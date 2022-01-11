class HazelcastAT502 < Formula
    desc "Tool to run Hazelcast IMDG member instances locally"
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://repo1.maven.org/maven2/com/hazelcast/hazelcast-distribution/5.0.2/hazelcast-distribution-5.0.2.tar.gz"
    sha256 "057dbbeb5fe1fb0ec77e4561e4dcf0f26ad917e1ade6f9ce8d232b5bb6a408cc"
    conflicts_with "hazelcast-enterprise"
  
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
      inreplace libexec/"lib/hazelcast-download.properties", "hazelcastDownloadId=distribution", "hazelcastDownloadId=brew"
    end
  
    def post_install
      # TODO fix once we have hz command in main distro
      exec "echo Hazelcast installed"
    end
  
  end
  