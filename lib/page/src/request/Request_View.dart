import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ssrapp/page/src/request/Request_ViewModel.dart';
import '../request_detail/RequestDetail_Model.dart';
import '../request_detail/RequestDetail_View.dart';

class Request extends StatefulWidget {
  @override
  RequestState createState() => RequestState();
}

class RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: ScopedModel(
        model: RequestViewModel(),
        child: ScopedModelDescendant<RequestViewModel>(builder:
            (BuildContext buildContext, Widget child, RequestViewModel model) {
          model.getAllRequest();
          return ListView.builder(
              itemCount:
                  model.requestList != null ? model.requestList.length + 1 : 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 0, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.collections_bookmark,
                              size: 21,
                            ),
                            Text(
                              " List of Requests",
                              style: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w800,
                                fontFamily: "Montserrat",
                                fontSize: 21.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  RequestDetailModel dto = model.requestList[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Request_Detail(
                                      requestDetailModel: dto,
                                    )));
                      },
                      child: Card(
                        elevation: 3,
                        shadowColor: (dto.status == "Waiting")
                            ? Colors.amberAccent
                            : (dto.status == "Rejected")
                                ? Colors.redAccent
                                : (dto.status == "Finished")
                                    ? Colors.lightGreen
                                    : (dto.status == "In-Progress")
                                        ? Colors.lightBlue
                                        : Colors.deepOrangeAccent,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, top: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              ticketIcon(dto.status),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ticketID(dto.ticketId),
                                              Spacer(),
                                              dueDatetime(dto.dueDatetime),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Card(
                                            color: (dto.status == "Waiting")
                                                ? Colors.amberAccent
                                                : (dto.status == "Rejected")
                                                    ? Colors.redAccent
                                                    : (dto.status == "Finished")
                                                        ? Colors.lightGreen
                                                        : (dto.status ==
                                                                "In-Progress")
                                                            ? Colors.lightBlue
                                                            : Colors
                                                                .deepOrangeAccent,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                dto.status,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              requestInfo(dto.serviceNm,
                                                  dto.departmentNm)
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                }
              });
        }),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _createHorizontalLine(double size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(height: 1.0, width: size, color: Colors.grey),
      );

  Widget ticketIcon(String status) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.label,
            size: 25,
            color: (status == "Waiting")
                ? Colors.amberAccent
                : (status == "Rejected")
                    ? Colors.redAccent
                    : (status == "Finished")
                        ? Colors.lightGreen
                        : (status == "In-Progress")
                            ? Colors.lightBlue
                            : Colors.deepOrangeAccent,
          )),
    );
  }

  Widget ticketID(String id) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: "Ticket ID:",
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
                text: '\n' + id, // ticket id
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget dueDatetime(String time) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Due Datetime: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 14)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.calendar_today,size: 18,),
              Text(" " + DateFormat('dd-MM-yyyy').format(DateTime.parse(time)),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.access_time,size: 18,),
              Text(" " + DateFormat('hh:mm:ss').format(DateTime.parse(time)),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget dueDatetimeIcon() {
    return Align(
        alignment: Alignment.topRight,
        child: Icon(
          Icons.schedule,
          color: Colors.red,
          size: 20,
        ));
  }

  Widget requestInfo(String service, String department) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.dvr,
                  size: 20,
                ),
                Text(
                  "  Service: " + service,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.assignment,
                  size: 20,
                ),
                Text(
                  "  Department: " + department,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
