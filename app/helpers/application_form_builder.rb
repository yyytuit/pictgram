class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def pick_errors(attribute)
    return nil if @object.nil? || (messages = @object.errors.messages[attribute]).nil?
    lis = messages.collect do |message|
      %{<li>#{message}</li>}
    end.join

    %{<ul class="errors">#{lis}</ul>}.html_safe
  end

  (field_helpers - [:label, :check_box, :radio_button, :fields_for, :hidden_field, :file_field]).each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(attribute, options = {})
        return super if options[:no_errors]

        super + pick_errors(attribute)
      end
    RUBY_EVAL
  end

  # def text_field(attribute, options={})
  #   return super if options[:no_errors]

  #   super + pick_errors(attribute)
  # end

  # def password_field(attribute, options={})
  #   return super if options[:no_errors]

  #   super + pick_errors(attribute)
  # end
end
