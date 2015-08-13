'use strict'

# React = require('react')

###################################
## Styles
###################################
styles =
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

  notification:
    background : '#000000'
    color      : '#FFFFFF'
    float      : 'left'
    lineHeight : '20px'
    padding    : '10px 10px 11px'
    position   : 'relative'
    textShadow : '0 1px 0 #333'

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

  notificationList:
    color: '#FFFFFF'



###################################
## JS
###################################
Notification = React.createClass
  render: () ->
    <div style={styles.notification}>
      <i style={styles.iconInbox}></i>
      <NotificationUnreadCount />
      <b style={styles.caret}></b>
    </div>

# NotificationToggle = React.createClass
#   render: () ->
#     <span className="notification-toggle">
#       <i style={styles.iconInbox} />
#       <NotificationUnreadCount />
#     </span>

NotificationUnreadCount = React.createClass
  render: () ->
    <span style={styles.unreadCount}>2</span>

React.render <Notification />, document.body



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

#   var NotificationsList = React.createClass({
#     render: function() {
#       return (
#         <div className="notifications-menu dropdown-menu">
#           <div className="header">
#             <a href="#" className="all-notifications">Central de notificações</a>
#             <span className="header-title">Notificações</span>
#           </div>
#           <div className="notifications">
#             {this.props.unreadNotifications.map(function(notification, i) {
#               return <Notification key={i} title={notification.tipo} content={notification.texto} />
#             })}
#           </div>
#         </div>
#       )
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

