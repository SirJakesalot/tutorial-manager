<%@ include file="header.jsp" %>
<style>
  .btn {
    min-height: 30px;
  }  
</style>

<div id="tree" class="tree well">
  <ul>
    <li>
      <span><i class="glyphicon glyphicon-folder-open"></i> ${tree.cat().name()}</span>
      <div id="${tree.cat().id()}" class="pull-right btn-group btn-group-sm" data-name="${tree.cat().name()}" data-label="${tree.cat().label()}" data-type="cat">
        <button class="btn btn-success" data-toggle="modal" data-target="#addNodeModal">
          <i class="glyphicon glyphicon-plus"></i>
        </button>
        <button class="btn btn-info" data-toggle="modal" data-target="#editCatModal">
          <i class="glyphicon glyphicon-edit"></i>
        </button>
      </div>
      <c:set var="node" value="${tree}" scope="request"></c:set>
      <jsp:include page="node.jsp"/>
    </li>
  </ul>
</div>


<div id="addNodeModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Node</h4>
      </div>
      <div class="modal-body">
        <div class="tabbable">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#addPage" data-toggle="tab">Add Page</a></li>
            <li><a href="#addCat" data-toggle="tab">Add Category</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="addPage">
              <br>
              <div class="input-group has-feedback">
                <input id="addPageName" type="text" class="form-control" placeholder="Page Name"/>
                <input id="addPageLabel" type="text" class="form-control" placeholder="Page Label"/>
              </div>
              <button type="button" class="btn btn-primary" onclick="addPage();">Submit</button>
            </div>
            <div class="tab-pane" id="addCat">
              <br>
              <div class="input-group has-feedback">
                <input id="addCatName" type="text" class="form-control" placeholder="Category Name"/>
                <input id="addCatLabel" type="text" class="form-control" placeholder="Category Label"/>
              </div>
              <button type="button" class="btn btn-primary" onclick="addCat();">Submit</button>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
        
        
<div id="editCatModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Category</h4>
      </div>
      <div class="modal-body">
        <select id="editCatPicker" data-live-search="true" data-live-search-style="contains" class="selectpicker"></select>
        <input id="editCatName" type="text" class="form-control" placeholder="New Category Name"/>
        <input id="editCatLabel" type="text" class="form-control" placeholder="New Category Label"/>
        <button type="button" class="btn btn-primary" onclick="editCat();">Submit</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div id="delCatModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Delete Category</h4>
      </div>
      <div class="modal-body">
        <p>Delete Category Data</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="delCat();">Submit</button>
      </div>
    </div>
  </div>
</div>

<div id="editPageModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Page</h4>
      </div>
      <div class="modal-body">
        <div class="input-group has-feedback">
          <input id="editPageName" type="text" class="form-control" placeholder="New Page Name"/>
          <input id="editPageLabel" type="text" class="form-control" placeholder="New Page Label"/>
        </div>
        <button type="button" class="btn btn-primary" onclick="editPage();">Submit</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div id="delPageModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Delete Page</h4>
      </div>
      <div class="modal-body">
        <p>Delete Page Data</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="delPage();">Submit</button>
      </div>
    </div>
  </div>
</div>

<script>
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
  $.each($('div').find('[data-type="cat"]'), function(i) {
    var opt = $('<option/>')
                .val($(this).attr('id'))
                .text($(this).data('label'));
    $.each($('.selectpicker'), function() {
      $(this).append(opt);
    });
  });
  $.each($('.selectpicker'), function() {
    $(this).selectpicker('refresh');
  });
});
$('.modal').on('show.bs.modal', function(e) {
  $(this).data('trigger', $(e.relatedTarget).parent().attr('id'));
});
$('#editCatModal').on('show.bs.modal', function(e) {
  var btn_group = $(e.relatedTarget).parent();
  if (btn_group.attr('id') == '${tree.cat().id()}') {
    $('#editCatModal .selectpicker').hide();
  } else {
    $('#editCatModal .selectpicker').show();
  }
  $('#editCatName').val($(e.relatedTarget).parent().data('name'));
  $('#editCatLabel').val($(e.relatedTarget).parent().data('label'));
});
$('#editPageModal').on('show.bs.modal', function(e) {
  $('#editPageName').val($(e.relatedTarget).parent().data('name'));
  $('#editPageLabel').val($(e.relatedTarget).parent().data('label'));
});


var addCatURL  = "${context}/api/addcat";
var delCatURL  = "${context}/api/delcat";
var editCatURL = "${context}/api/editcat";
var addPageURL  = "${context}/api/addpage";
var delPageURL  = "${context}/api/delpage";
var editPageURL = "${context}/api/editpage";
</script>

<%@ include file="footer.jsp" %>