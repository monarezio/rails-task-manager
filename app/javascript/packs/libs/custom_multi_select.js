const ready = () => {
    const html = $('html');
    if (html.attr('data-turbolinks-preview') === '')
        return;

    $('select').select2();
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);