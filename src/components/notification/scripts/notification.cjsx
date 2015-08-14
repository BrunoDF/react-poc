'use strict'

# React = require('react')

###################################
## Styles
###################################
styles =
  notificationComponent:
    background : '#000000'
    color      : '#FFFFFF'
    float      : 'right'
    fontSize   : '14px'
    lineHeight : '20px'
    padding    : '10px 10px 11px'
    position   : 'relative'
    textShadow : '0 1px 0 #333'

  caret:
    display: 'inline-block'
    borderTop: '4px solid #000'
    borderRight: '4px solid transparent'
    borderLeft: '4px solid transparent'
    borderTopColor: '#999'
    borderBottomColor: '#999'
    height: '0'
    margin: '8px 0 0 6px'
    verticalAlign: 'top'
    width: '0'

  iconInbox:
    backgroundImage    : 'url("http://office-sp.dclick.com.br/sesc-guideline/releases/2.2.0/img/glyphicons-halflings-white.png")'
    backgroundPosition : '-168px -24px'
    backgroundRepeat   : 'no-repeat'
    display            : 'inline-block'
    height             : '14px'
    lineHeight         : '14px'
    marginTop          : '1px'
    verticalAlign      : 'text-top'
    width              : '14px'

  unreadCount:
    background   : '#9d261d'
    borderRadius : '10px'
    bottom       : '-5px'
    boxShadow    : '0 2px 2px rgba(0,0,0,.5)'
    color        : '#F7F7F7'
    display      : 'inline-block'
    fontSize     : '9px'
    fontWeight   : '700'
    left         : '50%'
    lineHeight   : '15px'
    marginLeft   : '-12px'
    padding      : '0 5px 1px 5px'
    position     : 'absolute'
    textAlign    : 'center'
    width        : '15px'
    zIndex       : '1001'

  notificationsList:
    background     : '#FFFFFF'
    backgroundClip : 'padding-box'
    border         : '1px solid #ccc'
    border         : '1px solid rgba(0,0,0,.2)'
    borderRadius   : '5px'
    boxShadow      : '0 5px 10px 2px rgba(0,0,0,.5)'
    color          : '#333333'
    float          : 'left'
    left           : 'auto'
    listStyle      : 'none'
    margin         : '1px 0 0'
    minWidth       : '360px'
    padding        : '4px 0'
    position       : 'absolute'
    right          : '0'
    textShadow     : 'none'
    top            : '100%'
    zIndex         : '10002'

  notificationsListHeader:
    borderBottom : '1px solid #DDD'
    color        : '#111'
    padding      : '2px 10px 5px 10px'

  notificationsListHeaderTitle:
    fontSize     : '12px'
    fontWeight   : '700'

  notificationsListHeaderAllNotifications:
    float    : 'right'
    fontSize : '11px'
    margin   : '1px 0 0 0'

  notificationsListNotifications:
    maxWidth  : '380px'
    maxHeight : '400px'
    overflow  : 'auto'
    position  : 'relative'

  notificationBlock:
    borderBottom : '1px solid #e6e6e6'
    cursor       : 'pointer'
    display      : 'block'
    left         : '0'
    maxWidth     : '360px'
    position     : 'relative'
    padding      : '10px'
    transition   : 'background-color 1000ms linear'
    whiteSpace   : 'normal'
    wordWrap     : 'break-word'

  notificationDate: # Adicionar troca de visual - Radium
    borderRadius : '0 0 4px 4px'
    fontSize     : '9px'
    fontWeight   : '700'
    opacity      : '0'
    padding      : '2px 6px'
    position     : 'absolute'
    right        : '10px'
    textShadow   : '0 1px 1px #FFF'
    top          : '-1px'
    transition   : 'all 1000ms linear'

  notificationTitle:
    color      : '#666'
    fontSize   : '11px'
    fontWeight : '700'
    lineHeight : '1.4em'
    margin     : '0'

  notificationText:
    color      : '#666'
    fontSize   : '11px'
    lineHeight : '1.4em'
    margin     : '0'



###################################
## JS
###################################
NotificationComponent = React.createClass
  getInitialState: () ->
    return {
      collapsed           : yes
      unreadNotifications : []
      unreadCount         : 0
    }

  clickHandler: () ->
    @setState({
      collapsed : !@state.collapsed
    })

    if !@state.collapsed
      @markAsRead()

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
    )#.then (result) =>
      # @setState({
      #   unreadNotifications : []
      # })

  getUnread: () ->
    $.get 'http://localhost:3000/api/notificacoes/naolidas', (result) =>
      @setState({
        unreadNotifications: result
        unreadCount: result.length
      })

  componentDidMount: () ->
    @getUnread()
    setInterval(@getUnread, @props.interval)
    # window.addEventListener('mousedown', () =>
    #     @clickHandler() unless @state.collapsed
    #   , false)

  render: () ->
    <div style={styles.notificationComponent} onClick={@clickHandler}>
      <i style={styles.iconInbox}></i>
      <NotificationUnreadCount unreadCount={@state.unreadCount} />
      <b style={styles.caret}></b>
      <NotificationsList collapsed={@state.collapsed} unreadNotifications={@state.unreadNotifications} />
    </div>


NotificationUnreadCount = React.createClass
  render: () ->
    <span style={styles.unreadCount}>{@props.unreadCount}</span>


NotificationsList = React.createClass
  render: () ->
    if !@props.collapsed
      template =
        <div style={styles.notificationsList}>
          <div style={styles.notificationsListHeader}>
            <span style={styles.notificationsListHeaderTitle}>Notificações</span>
            <span style={styles.notificationsListHeaderAllNotifications}>Central de notificações</span>
          </div>
          <div style={styles.notificationsListNotifications}>
            {@props.unreadNotifications.map (notification, i) ->
              return <Notification key={i} data={notification} />
            }
          </div>
        </div>
    else
      template = null


Notification = React.createClass
  render: () ->
    <div style={styles.notificationBlock}>
      <small style={styles.notificationDate}>{@props.data.data}</small>
      <p style={styles.notificationTitle}>{@props.data.tipo}</p>
      <p style={styles.notificationText}>{@props.data.texto}</p>
    </div>

# <div className="notifications">
#   {this.props.unreadNotifications.map (notification, i) ->
#     return <Notification key={i} title={notification.tipo} content={notification.texto} />
#   }
# </div>

## Render Component
React.render <NotificationComponent interval="5000" />, document.body



# $.get('/api/notificacoes/naolidas').then((result) ->
#   console.log result
# )


# var Notifications = React.createClass({
#     getInitialState: function() {
#       return {
#         collapsed: true,
#         unreadNotifications: [],
#         unreadCount: 0
#       }
#     },
#     clickHandler: function(e) {
#       this.setState({
#         collapsed: !this.state.collapsed
#       })

#       if (this.state.collapsed) {
#         this.markAsRead();
#       }
#     },
#     markAsRead: function() {
#       var self = this;
#       // var ids =
#       $.post('http://localhost:3000/api/notificacoes/notificarleitura', {ids: [200607]});
#     },
#     getUnread: function() {
#       var self = this;
#       $.get('http://localhost:3000/api/notificacoes/naolidas', function(result) {
#         self.setState({
#           unreadNotifications: result,
#           unreadCount: result.length
#         })
#       });
#     },
#     componentDidMount: function() {
#       this.getUnread();
#       setInterval(this.getUnread, 5000);
#     },
#     # // componentWillUpdate: function(props, state) {
#     # //   if (!state.collapsed) {
#     # //     this.markAsRead();
#     # //   }
#     # // },
#     render: function() {
#       var isCollapsed = this.state.collapsed;
#       return (
#         <li className={isCollapsed ? 'dropdown notification-center' : 'dropdown notification-center open'} onClick={this.clickHandler}>
#           <NotificationsButton unreadCount={this.state.unreadCount} />
#           <NotificationsList unreadNotifications={this.state.unreadNotifications} />
#         </li>
#       )
#     }
#   });

#   var NotificationsButton = React.createClass({
#     render: function() {
#       return (
#         <a href="#" className="dropdown-toggle notification-toggle" data-toggle="dropdown">
#           <i className="icon-white icon-inbox"></i>
#           <UnreadNotificationCount unreadCount={this.props.unreadCount} />
#           <b className="caret"></b>
#         </a>
#       )
#     }
#   });

#   var UnreadNotificationCount = React.createClass({
#     render: function() {
#       var unreadCount = <span></span>;

#       if (this.props.unreadCount) {
#         unreadCount = <span style={styles.unread} className="notification-counter">{this.props.unreadCount}</span>
#       }

#       return unreadCount
#     }
#   });



#   var Notification = React.createClass({
#     render: function() {
#       return (
#         <a className="notification">
#           <div className="notification-block">
#             <small className="notification-date">10 minutos atrás</small>
#             <h6 className="notification-title">{this.props.title}</h6>
#             <p className="notification-text">
#              {this.props.content}
#             </p>
#           </div>
#         </a>
#       )
#     }
#   });

#   React.render(<Notifications />, document.getElementById('menulist'));

