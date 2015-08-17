'use strict'

###################################
## JS
###################################
NotificationComponent = React.createClass
  getInitialState: () ->
    return {
      collapsed           : yes
      mouseOver           : no
      unreadNotifications : []
      unreadCount         : 0
    }

  clickHandler: () ->
    @setState({
      collapsed : !@state.collapsed
    })

    if not @state.collapsed and @state.mouseOver
      @markAsRead()
    else if @state.collapsed and not @state.mouseOver
      @markAsRead()

  mouseOverHandler: () ->
    @setState({
      mouseOver : yes
    });

  mouseOutHandler: () ->
    @setState({
      mouseOver : no
    });

  markAsRead: () ->
    ids = []
    for unreadNotification in @state.unreadNotifications
      ids.push unreadNotification.id

    $.ajax(
      type: 'POST'
      url: 'http://localhost:3000/api/notificacoes/notificarleitura'
      contentType: 'application/json'
      data: JSON.stringify {ids: ids}
      dataType: 'json'
    ).then (result) =>
      @getUnread()

  getUnread: () ->
    $.ajax(
      type: 'GET'
      timeout: @props.interval
      url: 'http://localhost:3000/api/notificacoes/naolidas'
      contentType: 'application/json'
      dataType: 'json'
    ).then (result) =>
      @setState({
        unreadNotifications: result
        unreadCount: result.length
      })

  componentDidMount: () ->
    @getUnread()
    setInterval(@getUnread, @props.interval)
    window.addEventListener('mousedown', () =>
        @clickHandler() if not @state.mouseOver and not @state.collapsed
      , false)

  render: () ->
    <div className="notification-component" onClick={@clickHandler} onMouseOver={@mouseOverHandler} onMouseOut={@mouseOutHandler}>
      <i className="icon-inbox"></i>
      <NotificationUnreadCount unreadCount={@state.unreadCount} />
      <b className="caret"></b>
      <NotificationsList collapsed={@state.collapsed} unreadNotifications={@state.unreadNotifications} />
    </div>


NotificationUnreadCount = React.createClass
  componentDidMount: () ->
    $(@getDOMNode()).addClass('show') if @props.unreadCount

  componentDidUpdate: () ->
    if @props.unreadCount
      $(@getDOMNode()).addClass('show')
    else
      $(@getDOMNode()).removeClass('show')

  render: () ->
    <span className="unread-count">{@props.unreadCount}</span>


NotificationsList = React.createClass
  render: () ->
    if !@props.collapsed
      template =
        <div className="notification-list">
          <div className="header">
            <span className="title">Notificações</span>
            <span className="all-notifications">Central de notificações</span>
          </div>
          <div className="notifications">
            {@props.unreadNotifications.map (notification, i) ->
              return <Notification key={i} data={notification} />
            }
          </div>
        </div>
    else
      template = null


Notification = React.createClass
  componentDidMount: () ->
    $(@getDOMNode()).addClass('unread')

    setTimeout () =>
        $(@getDOMNode()).removeClass('unread')
      , 1000

  getDateDifferenceInMinutes: () ->
    currentDate      = new Date()
    notificationDate = new Date(@props.data.data)
    difference       = Math.floor ((currentDate - notificationDate) / (1000*60)) % 60 # Em minutos
    return difference

  render: () ->
    <div className="notification">
      <small className="date">{@getDateDifferenceInMinutes() + ' minutos atrás'}</small>
      <p className="title">{@props.data.tipo}</p>
      <p className="text">{@props.data.texto}</p>
    </div>


## Render Component
React.render <NotificationComponent interval="5000" />, document.body

