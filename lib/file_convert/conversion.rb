module FileConvert
  class Conversion
    attr_reader :file
    attr_reader :body

    ##
    # Downloads remote file from Google Drive with given mime_type
    #
    # @param [FileConvert::Client] client
    # @param [FileConvert::File] remote_file
    # @param [String] mime_type
    #   Target mime_type the file gets converted to
    #
    # @return [FileConvert::File] remote_file with requested #conversions
    def initialize(client, original_file, mime_type)
      @client = client
      @original_file = original_file
      @original_file_data = original_file.data
      @mime_type = mime_type

      # Raise if requested mime-type is not available
      unless export_links.has_key?(mime_type)
        raise missing_mime_type_exception
      end

      @file = fetch_file
      @body = @file.body
      @original_file.add_conversion(mime_type, self)
    end

    ##
    # Saves result as file
    # @param [String] target_path
    #
    # @return [FileConvert::Conversion]
    def save(target_path)
      File.open(target_path, 'w') { |file| file.write(@file.body) }
    end

    private

    ##
    # @return [Hash] available mime-type download URIs
    def export_links
      @original_file_data['exportLinks'].to_hash
    end

    ###
    # Actually downloads the file
    # Raises if request was not successfull
    #
    # @return [Google::APIClient::Result]
    def fetch_file
      @client.execute(uri: export_links[@mime_type]).tap do |result|
        raise connection_error_exception unless result.status == 200
      end
    end

    def missing_mime_type_exception
      Exception::MissingConversionMimeType.new(@mime_type, export_links.keys)
    end

    def connection_error_exception
      Exception::DownloadConnectionError.new(@file['error']['message'])
    end
  end
end
