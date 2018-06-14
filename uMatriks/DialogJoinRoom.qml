import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


Component {
   Dialog {
      id: dialog
      title: i18n.tr("Join room")
      text: i18n.tr("Join room:")

      function onJoinedRoom(room) {
         console.log("Joined room: " + room)
         PopupUtils.close(dialogJoinRoom.current)
         roomView.setRoom(room)
         mainAdaptiveLayout.addPageToNextColumn(mainAdaptiveLayout.primaryPage,roomView)
      }

      Component.onCompleted: {
         console.log("Popup opened!")
         connection.joinedRoom.connect(onJoinedRoom)
      }

      TextField {
         id: room
         text: "#tensor:matrix.org"
         width: parent.width
      }

      Row {
         anchors.margins: units.gu(1)
         width: parent.width
         spacing: width - joinDialogCancelBut.width - joinDialogJoinBut.width

         Button {
            id:joinDialogCancelBut
            text: i18n.tr("Cancel")
            onClicked: {
               PopupUtils.close(dialogJoinRoom.current);
               console.log("Cancel");
            }
         }

         Button {
            id:joinDialogJoinBut
            text: i18n.tr("Join")
            color: UbuntuColors.orange
            onClicked: {
               console.log("Joining room: " + room.text);
               connection.joinRoom(room.text);
            }
         }
      }
   }
}
