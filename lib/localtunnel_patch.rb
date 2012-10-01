class LocalTunnel::Tunnel

  #
  # Replace sleep call in start_tunnel with a yield to a block to be executed
  # once the tunnel is established.
  #
  def start_tunnel
    port = @port
    tunnel = @tunnel
    gateway = Net::SSH::Gateway.new(tunnel['host'], tunnel['user'])
    gateway.open_remote(port.to_i, '127.0.0.1', tunnel['through_port'].to_i) do |rp,rh|
      puts "   " << tunnel['banner'] if tunnel.has_key? 'banner'
      puts "   Port #{port} is now publicly accessible from http://#{tunnel['host']} ..."
      begin
        yield
      rescue Interrupt
        gateway.close_remote(rp, rh)
        exit
      end
    end
  rescue Net::SSH::AuthenticationFailed
    possible_key = Dir[File.expand_path('~/.ssh/*.pub')].first
    puts "   Failed to authenticate. If this is your first tunnel, you need to"
    puts "   upload a public key using the -k option. Try this:\n\n"
    puts "   localtunnel -k #{possible_key ? possible_key : '~/path/to/key'} #{port}"
    exit
  end
end
