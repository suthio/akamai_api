module AkamaiApi
  module Cli
    class CcuCpCode < Command
      namespace 'ccu cpcode'

      desc 'remove CPCODE1 CPCODE2 ...', 'Purge CP Code(s) removing them from the cache'
      method_option :domain,   :type => :string, :aliases => '-d',
                    :banner => 'production|staging',
                    :desc => 'Optional argument used to specify the environment. Usually you will not need this option'
      method_option :banner => "foo@foo.com bar@bar.com",
                    :desc => 'Email(s) used to send notification when the purge has been completed'
      def remove(*cpcodes)
        purge_action :remove, cpcodes
      end

      desc 'invalidate CPCODE1 CPCODE2 ...', 'Purge CP Code(s) marking their cache as expired'
      method_option :domain,   :type => :string, :aliases => '-d',
                    :banner => 'production|staging',
                    :desc => 'Optional argument used to specify the environment. Usually you will not need this option'
      method_option :banner => "foo@foo.com bar@bar.com",
                    :desc => 'Email(s) used to send notification when the purge has been completed'
      def invalidate(*cpcodes)
        purge_action :invalidate, cpcodes
      end

      no_tasks do
        def purge_action type, cpcodes
          if cpcodes.blank?
            puts 'You should provide at least one valid CP Code'
            return
          end
          load_config
          res = AkamaiApi::Ccu.purge type, :cpcode, cpcodes, :domain => options[:domain]
          puts '------------'
          puts AkamaiApi::Cli::Template.ccu_response res
          puts '------------'
        rescue AkamaiApi::Ccu::Unauthorized
          puts "Your login credentials are invalid or the CPCode you entered belongs to someone else"
        end
      end
    end
  end
end