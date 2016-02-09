$(document).on('page:change', () => {
  if ($('.polls.results').length == 0 ) {
    return
  }

  function draw(data) {
    const color = d3.scale.category20b()
    const width = 420,
      barHeight = 20

    const totalVotes = data.map(e => e.count).reduce((prev, curr) => prev + curr)

    const x = d3.scale.linear()
      .range([0, width])
      .domain([0, d3.max(data.map(e => e.count))])

    const chart = d3.select("#graph")
      .attr("width", width)
      .attr("height", barHeight * data.length)

    const bar = chart.selectAll("g")
      .data(data)
      .enter().append("g")
      .attr("transform", function (d, i) {
        return "translate(0," + i * barHeight + ")"
      })

    bar.append("rect")
      .attr("width", (d) => x(d.count))
      .attr("height", barHeight - 1)
      .style("fill", function (d) {
        return color(d.count)
      })

    bar.append("text")
      .attr("x", function (d) {
        return x(d.count) - 105
      })
      .attr("y", barHeight / 2)
      .attr("dy", ".35em")
      .style("fill", "white")
      .text((d) => {
        const pct = d.count / totalVotes * 100
        const voteOrVotes = d.count === 1 ? 'vote' : 'votes'
        return `${d.count} ${voteOrVotes} (${pct.toFixed(0)}%)`
      })

    bar.append("text")
      .attr("x", 5)
      .attr("y", barHeight / 2)
      .attr("dy", ".35em")
      .style("fill", "white")
      .text(function (d) {
        return d.text
      })
  }

  function getData(token) {
    fetch('http://laguz:3000/' + token + '/data', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    })
      .then(resp => resp.json())
      .then(json => {
        draw(json)
      })
  }

  getData($('#resultsContainer').data('token'))
})