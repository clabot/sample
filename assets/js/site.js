(function() {
  $(function() {
    var metrics,
        options,
        $button = $('button[type=submit]'),
        $form   = $('form');
    metrics = [
      ['#name', 'presence', 'Fill in your Full Name'],
      // nod's email regex is incorrect
      ['#email', /^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$/, 'Fill in a valid E-Mail Address'],
      ['#github', /^[a-zA-Z0-9\_\-]+$/, 'We need your correct GitHub username to match contributions with this Agreement'],
      ['#email, #address, #country, #tel', 'presence', 'This is a required field'],
      ['#signature', /^I\sAGREE$/, 'Fill in "I AGREE"']];
    options = {
      helpSpanDisplay: 'help-block'
    };

    $form.nod(metrics, options);
    $form.submit(function(e) {
      $button.attr('disabled', 'disabled').text('Submitting...');
      $.ajax({
        type: 'POST',
        url: '/form',
        data: $form.serialize(),
        success: function(data, textStatus, jqXHR) {
          $button.text('Thanks for your submission').removeClass('btn-primary btn-danger').addClass('btn-success');
        },
        error: function(error, textStatus, jqXHR) {
          $button.removeAttr('disabled').text('Please try again. Something went wrong').removeClass('btn-primary btn-success').addClass('btn-danger');
        }
      });
      e.preventDefault();
    });
  });

}).call(this);
