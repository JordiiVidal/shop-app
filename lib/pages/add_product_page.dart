import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class AddProductPage extends StatefulWidget {
  static const routeName = '/add';
  const AddProductPage({Key key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _newProductForm = ProductForm();

  @override
  void initState() {
    super.initState();
    _imageUrlController.text =
        'https://dainese-cdn.thron.com/delivery/public/image/dainese/9417d5d6-4b63-4891-bb9f-b84f811bf008/ramfdh/std/615x615/torque-3-out-boots.jpg';
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlController.dispose();
    _imageFocus.dispose();
  }

  void saveButton() {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_newProductForm);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt),
        onPressed: saveButton,
      ),
      appBar: AppBar(
        title: Text('Add new Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),

                textInputAction: TextInputAction.next,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) return 'Please provide Title';
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocus),
                onSaved: (val) => _newProductForm.title = val,
              ),
              TextFormField(
                focusNode: _priceFocus,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a price';
                  } else if (double.tryParse(value) == null) {
                    return 'Enter a valid price';
                  }
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocus),
                onSaved: (val) => _newProductForm.price = double.parse(val),
              ),
              TextFormField(
                maxLines: 3,
                focusNode: _descriptionFocus,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                onSaved: (val) => _newProductForm.description = val,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(0),
                      child: Image.network(
                        _imageUrlController.text.isEmpty
                            ? 'https://superprosamui.com/2016/wp-content/plugins/ap_background/images/default/default_large.png'
                            : _imageUrlController.text,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image Url',
                        ),
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageFocus,
                        onSaved: (val) => _newProductForm.imageUrl = val,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
