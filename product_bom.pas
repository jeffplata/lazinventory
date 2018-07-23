unit product_BOM;

{$mode objfpc}

interface

uses
  Classes, SysUtils
  ,tiObject;

type
  TProduct = class;
  TProductList = class;

  TProductCategory = class;
  TProductCategoryList = class;

  { TProductCategory }

  TProductCategory = class(TtiObject)
  private
    FDescription: string;
    procedure SetDescription(AValue: string);
  protected
    function  GetOwner: TProductCategoryList; reintroduce;
    procedure SetOwner(const Value: TProductCategoryList); reintroduce;
    function GetCaption: string;
  public
    property  Owner: TProductCategoryList read GetOwner write SetOwner;
  published
    property  Description: string read FDescription write SetDescription;
    property Caption: string read GetCaption;
  end;

  { TProductCategoryList }

  TProductCategoryList = class(TtiObjectList)
  private
  protected
    function  GetItems(i: integer): TProductCategory; reintroduce;
    procedure SetItems(i: integer; const Value: TProductCategory); reintroduce;
    //function  GetOwner: TOwnerClass; reintroduce;
    //procedure SetOwner(const Value: TOwnerClass); reintroduce;
  public
    property  Items[i:integer]: TProductCategory read GetItems write SetItems;
    procedure Add(AObject:TProductCategory); reintroduce;
    //property  Owner: TOwnerClass read GetOwner write SetOwner;
  published
  end;

  { TProduct }

  TProduct = class(TtiObject)
  private
    FCategory: TProductCategory;
    FDescription: string;
    procedure SetCategory(AValue: TProductCategory);
    procedure SetDescription(AValue: string);
  protected
    function  GetOwner: TProductList; reintroduce;
    procedure SetOwner(const Value: TProductList); reintroduce;
  public
    property  Owner: TProductList read GetOwner write SetOwner;
  published
    property Description: string read FDescription write SetDescription;
    property Category: TProductCategory read FCategory write SetCategory;
  end;

  { TProductList }

  TProductList = class(TtiObjectList)
  private
    //procedure SetOwner(AValue: TProduct);
  protected
    function  GetItems(i: integer): TProduct; reintroduce;
    procedure SetItems(i: integer; const Value: TProduct); reintroduce;
    //function  GetOwner: TProductList; reintroduce;
    //procedure SetOwner(const Value: TProductList); reintroduce;
  public
    property  Items[i:integer]: TProduct read GetItems write SetItems;
    //property  Owner: TProduct read GetOwner write SetOwner;
    procedure Add(AObject:TProduct); reintroduce;
  published
  end;


implementation

{ TMarkObject }

{ TProductCategoryList }

function TProductCategoryList.GetItems(i: integer): TProductCategory;
begin
  result := TProductCategory(inherited GetItems(i));
end;

procedure TProductCategoryList.SetItems(i: integer; const Value: TProductCategory
  );
begin
  inherited SetItems(i, Value);
end;

procedure TProductCategoryList.Add(AObject: TProductCategory);
begin
  inherited Add(AObject);
end;

{ TProductCategory }

procedure TProductCategory.SetDescription(AValue: string);
begin
  if FDescription=AValue then Exit;
  FDescription:=AValue;
end;

function TProductCategory.GetOwner: TProductCategoryList;
begin
  result := TProductCategoryList(inherited GetOwner);
end;

procedure TProductCategory.SetOwner(const Value: TProductCategoryList);
begin
  inherited SetOwner(Value);
end;

function TProductCategory.GetCaption: string;
begin
  result := Description;
end;


{ TProductList }

//procedure TProductList.SetOwner(AValue: TProduct);
//begin
//  inherited SetOwner(AValue);
//end;

function TProductList.GetItems(i: integer): TProduct;
begin
  result := TProduct(inherited GetItems(i));
end;

procedure TProductList.SetItems(i: integer; const Value: TProduct);
begin
  inherited SetItems(i, Value);
end;

//function TProductList.GetOwner: TProductList;
//begin
//  result := TProductList(inherited GetOwner);
//end;

//procedure TProductList.SetOwner(const Value: TProductList);
//begin
//  inherited SetOwner(Value);
//end;

procedure TProductList.Add(AObject: TProduct);
begin
  inherited Add(AObject);
end;

{ TProduct }

procedure TProduct.SetDescription(AValue: string);
begin
  if FDescription=AValue then Exit;
  FDescription:=AValue;
  NotifyObservers;
end;

procedure TProduct.SetCategory(AValue: TProductCategory);
begin
  if FCategory=AValue then Exit;
  FCategory:=AValue;
  NotifyObservers;
end;

function TProduct.GetOwner: TProductList;
begin
  result := TProductList(inherited GetOwner);
end;

procedure TProduct.SetOwner(const Value: TProductList);
begin
  inherited SetOwner(Value);
end;


end.

