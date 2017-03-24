$(function () {
  $('#tree li:has(ul)')
    .addClass('parent_li')
    .find(' > span')
    .attr('title', 'Collapse this branch');
  $('#tree li.parent_li > span')
    .on('click', function (e) {
      var children = $(this).parent('li.parent_li').find(' > ul > li');
      if (children.is(":visible")) {
        children.hide('fast');
        $(this)
          .attr('title', 'Expand this branch')
          .find(' > i')
          .addClass('glyphicon-folder-close')
          .removeClass('glyphicon-folder-open');
      } else {
        children.show('fast');
        $(this)
          .attr('title', 'Collapse this branch')
          .find(' > i')
          .addClass('glyphicon-folder-open')
          .removeClass('glyphicon-folder-close');
      }
      e.stopPropagation();
  });
});
