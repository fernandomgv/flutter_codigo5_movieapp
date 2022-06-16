
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/model/genres_model.dart';

class ItemFilterWidget extends StatefulWidget {
 // const ItemFilterWidget({Key? key}) : super(key: key);

  bool? isSelected;
  //String textFilter;
  GenresModel filter;
  List<int> withGenresList;
  ItemFilterWidget({
    required this.filter,
    required this.withGenresList,
    this.isSelected=false,
});

  @override
  State<ItemFilterWidget> createState() => _ItemFilterWidgetState();
}

class _ItemFilterWidgetState extends State<ItemFilterWidget> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.isSelected = !widget.isSelected!;
        if(widget.isSelected!)
          {
            if(widget.filter.id==0)
              {
                widget.withGenresList.clear();
              }else {
              widget.withGenresList.add(widget.filter.id);
            }

          }else {
          widget.withGenresList.remove(widget.filter.id);
        }
        print("dede Itemfilter ${widget.withGenresList}");
        setState(() {

        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color:widget.isSelected! ? Color(0xff23dec3) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widget.isSelected! ? Color(0xff23dec3) : Colors.white70,
          ),
          boxShadow: widget.isSelected! ? [
            BoxShadow(
              color: const Color(0xff23dec3).withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ] : [],
          gradient: widget.isSelected! ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff5de09c),
              Color(0xff23dec3),
            ],
          ) : null,
        ),
        child: Text(widget.filter.name,
          style: TextStyle(
              color: widget.isSelected! ? Colors.black : Colors.white,
              fontWeight: widget.isSelected! ? FontWeight.w500 : FontWeight.normal,
          ),),
      ),
    );
  }
}
