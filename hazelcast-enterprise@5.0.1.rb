class HazelcastEnterpriseAT501 < Formula
    desc "Tool to run Hazelcast IMDG member instances locally"
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://repository.hazelcast.com/release/com/hazelcast/hazelcast-enterprise-distribution/5.0.1/hazelcast-enterprise-distribution-5.0.1.tar.gz"
    sha256 "a2025f1ded0f46b7fd6a413f5dc0833d954076e68e15b0b95d2fd2c7bc191424"
    conflicts_with "hazelcast"
  
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
  