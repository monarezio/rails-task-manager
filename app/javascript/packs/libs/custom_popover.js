const ready = () => {
    const html = $('html');
    if (html.attr('data-turbolinks-preview') === '') {
        console.log('Turbolinks load');
        return;
    }

    const popoverButton = $('[data-toggle="popover"]');
    popoverButton.popover();

    let isLocked = true;
    const lock = $('#unlock-category');
    lock.children('.unlocked').hide();

    const deleteButton = $('#delete-buttons');
    deleteButton.children('a').hide();

    lock.click((e) => {
        e.preventDefault();

        isLocked = !isLocked;
        lock.children().toggle();
        deleteButton.children().toggle();

        popoverButton.popover('hide')
    });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);