class HazelcastEnterpriseAT51Snapshot < Formula
    desc "Tool to run Hazelcast IMDG member instances locally"
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://repository.hazelcast.com/snapshot/com/hazelcast/hazelcast-enterprise-distribution/5.1-SNAPSHOT/hazelcast-enterprise-distribution-5.1-20220111.010941-279.tar.gz"
    sha256 "e7d01c7def186c69170c1428d3e07be8b39ad63941551ee2929f55bf01bae1c3"
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
  