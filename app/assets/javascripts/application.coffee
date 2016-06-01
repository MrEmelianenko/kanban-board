#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require turbolinks
#= require cocoon
#= require summernote
#= require jquery-ui/sortable
#= require_tree .

ready = ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote()

  $('#issues-backlog, #issues-in-progress, #issues-in-review, #issues-done').sortable({
    handle: '.panel-heading',
    connectWith: '.issues-board',
    placeholder: 'issues-board-item-placeholder',
    stop: (event, ui) ->
      _this = this;
      issue_data = ui.item.data();
      state_was = issue_data.state;
      state = ui.item.parent().data('state');

      return if state_was == state

      $.ajax(
        type: 'PATCH',
        url: '/api/issues/' + issue_data.id + '/change-state',
        data: { state: state }
      )
      .done(() ->
        ui.item.data('state', state)
      )
      .fail((error) ->
        $(_this).sortable('cancel')
        alert(error.responseJSON.message || 'Oups, something went wrong')
      )


  }).disableSelection()

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
