$(document).on('ready turbolinks:load', () => {
    $('[data-toggle="popover"]').popover();

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
    });
});