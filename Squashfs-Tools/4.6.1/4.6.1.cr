class Target < ISM::Software

    def prepare
        @buildDirectory = true
        @buildDirectoryNames["MainBuild"] = "squashfs-tools"
        super
    end

    def build
        super

        makeSource( arguments:  "GZIP_SUPPORT=1     \
                                LZ4_SUPPORT=1       \
                                LZMA_XZ_SUPPORT=1   \
                                LZO_SUPPORT=1       \
                                XATTR_SUPPORT=1     \
                                XZ_SUPPORT=1        \
                                ZSTD_SUPPORT=1",
                    path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "INSTALL_PREFIX=\"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr\" \
                                INSTALL_MANPAGES_DIR=\"$(INSTALL_PREFIX)/share/man/man1\"                     \
                                install",
                    path:       buildDirectoryPath)
    end

end
