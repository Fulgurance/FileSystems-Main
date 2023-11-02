class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--enable-compat-symlinks",
                            "--mandir=/usr/share/man",
                            "--docdir=/usr/share/doc/dosfstools-4.2"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
