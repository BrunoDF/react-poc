'use strict'

# React = require('react')

Notification = React.createClass
  render: () ->
    <div className="notification notification-center">
      <NotificationToggle />
    </div>

NotificationToggle = React.createClass
  render: () ->
    <span className="notification-toggle">
      <NotificationUnreadCount />
    </span>

NotificationUnreadCount = React.createClass
  render: () ->
    <span className="notification-counter">2</span>

React.render <Notification />, document.body
# $.get('/api/notificacoes/naolidas').then((result) ->
#   console.log result
# )

# var styles = {
#   unread: {
#     color: '#FFF'
#   }
#   // notificationList: {

#   // }
# }


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

