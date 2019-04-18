struct Config {
    // Set your Mac local ip, check it tools like `ifconfig`
    private static let ip: String = "172.22.179.179"
    static let streamUrl: String = "rtmp://\(ip)/live"
    static let streamKey: String = "Hoge"
}
