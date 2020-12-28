import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit';
  const EditProductPage({Key key}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  ProductForm _newProductForm = ProductForm();
  bool _isInit = true;
  Product _editProduct;
  var idProduct;

  @override
  void initState() {
    super.initState();
    _imageUrlController.text =
        'https://dainese-cdn.thron.com/delivery/public/image/dainese/9417d5d6-4b63-4891-bb9f-b84f811bf008/ramfdh/std/615x615/torque-3-out-boots.jpg';
  }

  //before build
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      //only first time
      final productId = ModalRoute.of(context).settings.arguments as String;
      _editProduct = Provider.of<Products>(context).productById(productId);
      _imageUrlController.text = _editProduct.imageUrl;
      idProduct = productId;
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlController.dispose();
    _imageFocus.dispose();
  }

  void saveButton(BuildContext context) {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    bool edited = Provider.of<Products>(context, listen: false)
        .editProduct(idProduct, _newProductForm);
    if (!edited) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Please check all fields and try again')),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt),
        onPressed: () => saveButton(context),
      ),
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _editProduct.title,
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
                initialValue: _editProduct.price.toString(),
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
                initialValue: _editProduct.description,
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
