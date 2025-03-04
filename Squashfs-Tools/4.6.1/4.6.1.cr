class Target < ISM::Software

    def prepare
        @buildDirectory = true
        @buildDirectoryNames["MainBuild"] = "squashfs-tools"
        super
    end

    def build
        super

        makeSource( arguments:  "GZIP_SUPPORT=#{option("Gzip") ? "1" : "0"} \
                                LZ4_SUPPORT=#{option("Lz4") ? "1" : "0"}    \
                                LZMA_XZ_SUPPORT=1                           \
                                LZO_SUPPORT=1                               \
                                XATTR_SUPPORT=1                             \
                                XZ_SUPPORT=#{option("Xz") ? "1" : "0"}      \
                                ZSTD_SUPPORT=#{option("Zstd") ? "1" : "0"}",
                    path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "install",
                    path:       buildDirectoryPath,
                    environment: {  "INSTALL_PREFIX" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr"},
                                    "INSTALL_MANPAGES_DIR" => "$(INSTALL_PREFIX)/share/man/man1")
    end

end
