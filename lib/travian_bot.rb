Dir.glob(File.join(File.dirname(__FILE__), '/travian_bot/*.rb')).sort.each { |lib| load lib }
