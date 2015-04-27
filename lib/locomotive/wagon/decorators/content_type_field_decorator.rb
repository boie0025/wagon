module Locomotive
  module Wagon

    class ContentTypeFieldDecorator < SimpleDelegator

      include ToHashConcern

      def __attributes__
        %i(name type label hint required localized unique position
          text_formatting select_options
          target inverse_of order_by ui_enabled)
      end

      def type
        self[:type]
      end

      def hint
        self[:hint]
      end

      def position
        self[:position]
      end

      def text_formatting
        return nil unless type == :text

        self[:text_formatting]
      end

      def target
        return nil unless is_relationship?
        self.target_id
      end

      def inverse_of
        return nil unless is_relationship?
        self[:inverse_of]
      end

      def order_by
        return nil unless is_relationship?
        self[:order_by]
      end

      def ui_enabled
        return nil unless is_relationship?
        self[:order_by]
      end

      def select_options
        return nil unless type == :select

        @_select_options ||= __getobj__.select_options.all.map { |o| SelectOptionDecorator.new(o) }
      end

      class SelectOptionDecorator < SimpleDelegator

        include ToHashConcern

        def __attributes__
          %i(name)
        end

        def name
          translations = __getobj__.name.translations
          translations.empty? ? translations[:any] : translations
        end

      end

    end

  end
end
