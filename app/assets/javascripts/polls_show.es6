$(document).on('page:change', () => {
  if ($('.polls.show').length == 0 ) {
    return
  }

  function getCookie(name) {
    const value = "; " + document.cookie;
    const parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
  }

  function castVote(id) {
    const token = $('#voteContainer').data('token')

    fetch('http://laguz:3000/vote/' + token, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'option_id': id,
        'uid': getCookie('uid')
      })
    })
      .then((resp) => resp.json())
      .then((json) => {
        if (json.result !== 'OK') {
          console.log(`Error voting: ${json.result}`)
          window.alert('Could not cast vote. You\'ve already voted.')
        }

        if (json.uid) {
          document.cookie = 'uid=' + json.uid
        }
      })
  }

  $('#castVote').on('click', () => castVote($('input[name=option]:checked').val()))

  $('#goToResults').on('click', e => window.location.href = e.target.dataset['url'])
})