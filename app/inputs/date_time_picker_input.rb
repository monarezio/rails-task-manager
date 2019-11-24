# https://edruder.com/blog/2018/01/27/bootstrap-date-time-picker-in-simple-form.html

class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.text_field(attribute_name, merged_input_options)
  end
end
