unit product_BOM;

{$mode objfpc}

interface

uses
  Classes, SysUtils
  ,tiObject;

type
  TProduct = class;
  TProductList = class;

  { TProduct }

  TProduct = class(TtiObject)
  private
    FDescription: string;
    procedure SetDescription(AValue: string);
  protected
    function  GetOwner: TProductList; reintroduce;
    procedure SetOwner(const Value: TProductList); reintroduce;
  public
    property  Owner: TProductList read GetOwner write SetOwner;
  published
    property Description: string read FDescription write SetDescription;
  end;

  { TProductList }

  TProductList = class(TtiObjectList)
  private
    procedure SetOwner(AValue: TProduct);
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

{ TProductList }

procedure TProductList.SetOwner(AValue: TProduct);
begin
  inherited SetOwner(AValue);
end;

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

function TProduct.GetOwner: TProductList;
begin
  result := TProductList(inherited GetOwner);
end;

procedure TProduct.SetOwner(const Value: TProductList);
begin
  inherited SetOwner(Value);
end;

end.

