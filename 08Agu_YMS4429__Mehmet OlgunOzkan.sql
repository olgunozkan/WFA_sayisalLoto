
---------------------------------
--�DEV 1
--------------------------------

--Telefon Numaras�n�n Formatlanmas�
--insert into Shippers values('�irket ad�', dbo.FormatPhone('2132313213'))

Alter FUNCTION FormatPhone
(
		@Phone NVARCHAR(24)
)
RETURNS NVARCHAR(24)
	Begin
		DECLARE		@Result Nvarchar(24)
		Set			@Phone	= (SELECT RTRIM(LTRIM(@Phone)))
		SET			@Phone  = (SELECT RIGHT(@Phone, 10))			
		SET			@result = (SELECT '+90 ('+(SELECT LEFT(@Phone,3))) + ' ) ' +
		(SELECT SUBSTRING(@Phone,4,3)) + ' ' +
		(SELECT SUBSTRING(@Phone,7,2)) + ' ' + (SELECT SUBSTRING(@Phone,9,2))
		Return @Result;
	End;

--Fonksiyona deger a�ag�daki gibi veriliyor.
Insert Into Shippers Values('AbdulRezzak',dbo.FormatPhone('009634566537'))

	Select * From Shippers
	Order By 1 Desc

---------------------------------
--�DEV 2
--------------------------------

-- T�m a��klamalar mevcut

-- Tablo Ad� = " Country ", Parametreler = Id, CountryName,Code
-- Tablo Ad� = " City",     Parametreler = Id, CityName, CountryId,Code
-- Tablo Ad� = " District", Parametreler = Id, DistrictName, CountryId, CityId,Code
-- Tablo Ad� = " Town",     Parametreler = Id, TownName, CountryId, CityId, DistrictId,code


Create Database EartyByCountry;
go
Use EartyByCountry;
Go
Create Table	Countries (
				CountryId		Int Primary Key Identity(1,1) Not Null,
				CountryName		Nvarchar(50) Null,
				Code			Nvarchar(50) Null,
)
Go

Create Table	Cities (
				CityId			Int Primary Key Identity(1,1) Not Null,
				CityName		Nvarchar(50) Null,
				CountryId		Int Foreign Key References Countries,
				Code			Nvarchar(50) Null,
)
Go

Create Table	Districts (
				DistrictId		Int Primary Key Identity(1,1) Not Null,
				DistrictName	Nvarchar(50) Null,
				CountryId		Int Not Null,
				CityId			Int Foreign Key References Cities,
				Code			Nvarchar(50) Null,
)
Go
Create Table	Towns (
				TownId			Int Primary Key Identity(1,1) Not Null,
				TownName		Nvarchar(50) Null, 
				CountryID		Int Not Null, 
				CityId			Int Not Null, 
				DistrictId		Int Foreign Key References Districts,
				Code			Nvarchar(50) Null,
)
---------------------------------------------------------------------------------------

---------------------------------
--�DEV 3
--------------------------------

/*
  NOT : Yeni bir veri taban� kod ile olu�turulacak :)
  1) Yukar�daki tablolar Code ile olu�turulacak ve kod ile �li�kilendirilecektir.
  2) Bir adet StoreProcedure yaz�lacak ve bu procedure i�erisine parametre olarak
  , �lke Ad�, �ehir Ad�, �l�e Ad� ve Mahalle Ad� alacak.
  3) �lkeler tablosunda parametrede g�nderilen �lke var m� yok mu kontrol edilecek. 
    3.1) E�er �lke Yok ise Eklenecek. Var ise kullan�c�ya mesaj ile bildirilecek
  4) �ehirler tablosunda parametrede g�nderilen �lke Kontol edilecek ve 
  Bu �lkeye ait B�lyle bir �ejir olup olmad��� kontrol edilecek. 
    4.1) E�er �ehir yok ise eklenecek. Var ise O �lkenin Id paramtresi yakalanacak ve 
	o Id paramteresine g�re �ehirler tablosuna kay�t eklenecek.
  5) �l�eler tablosunda parametrede g�nderilen �lke o �lkeye ba�l� �ehir ve o �ehire ba�l� �l�e varm� yok mu kontrol edilecek.
    5.1) E�er �lke Yok ise, �lke eklenecek. Sonra eklenen �lkenin Id parametresine g�re �l eklenecek. Sonras�nda ise, �lke Id ve �l Id parametreleri yakalan�p il�e eklenecek.
    5.2) E�er �lke var �ehir yok ise, parametrede g�nderilen �lke Id yakalan�p �ehir eklenecek ve Ulke Id ile �ehir Id parametrelerini kullanarak �l�eyi Eklenecek.
  6) Mahalle tablosunda parametrede g�nderilen �lke, o �lkeye ba�l� �ehir, o �ehire ba�l� il�e varm� yok mu kontrol edilecek.
    6.1) E�er �lke yok ise; �nce �lke eklenecek ve o �lkenin Id parametresine g�re �l, �lke ve �l Id parametrelerine g�re il�e, Ulke �l ve �l�e Id parametrelerine g�re de Mahalle eklenecek.
    6.2) E�er �lke var ise ve �ehir yok  ise O �lke Id parametresine g�re �ehir,, �lke ve �ehir Id parametresine g�re �l�e, �lke  �ehir il�e Id parametrelerine g�re Mahalle eklenecek.
    6.3) E�er �lke �l var ama il�e yok ise, �lke �ehir Id parametreleri yakalanacak ve �l�e eklenecek. Sonras�nda �lke �ehir ve �l�e Id parametreleri yakalnarak Mahalle Eklenecek
    6.4) E�er �lke il il�e var ama mahalle yok ise, �lke �l �l�e Id parametreleri kullan�larak Mahalle eklenecektir.
	NOT : �l ve �ehir Ayn� Anlama Gelir :) art� (+) her blok i�erisinde mesaj verilecek
*/

Create Proc sp_AddCountriesToDatabase
			@AddCountries	Nvarchar(50),
			@AddCities		Nvarchar(50),
			@AddDistricts	Nvarchar(50),
			@AddTowns		Nvarchar(50)
As

Declare		@CountryName		Nvarchar(50), 
			@CityName			Nvarchar(50), 
			@DistrictName		Nvarchar(50),
			@TownName			Nvarchar(50),
			@GetTownName		Nvarchar(50),
			@GetCountryName		Nvarchar(50),
			@GetCityName		Nvarchar(50),
			@GetDistrictName	Nvarchar(50),
			@CountryId			Int,
			@CityId				Int,
			@DistrictId			Int

		SET @GetCountryName  = @AddCountries
		Set @GetCityName	 = @AddCities
		Set @GetDistrictName = @AddDistricts
		Set @GetTownName	 = @AddTowns

Set		@CountryName = '-'
Select  @CountryName = CountryName
From	Countries
Where	CountryName = @GetCountryName 

If (@CountryName = @GetCountryName)
					Begin								
							Print @GetCountryName +' '+'�lkesi Mevcuttur.'
					End
If(@CountryName != @GetCountryName)
					Begin
								Insert Into Countries Values(@GetCountryName, GetDate())

							Print @GetCountryName +' '+'�lkesi Eklendi...'
					End
---------------------------------------------------------------------------------------
Set		@CityName = '-'
Select  @CityName = CityName 
From	Cities
Where	CityName = @GetCityName

If(@CityName = @GetCityName)
					Begin 			
							Print @GetCityName +' '+'�ehri Mevcuttur.'
					End
if(@GetCityName != @CityName)
					Begin				
							Select @CountryId =  CountryId
							From Countries			
							Where CountryName = @GetCountryName
							
								Insert Into Cities Values(@GetCityName,@CountryId,getdate())			
							
							Print @GetCityName +' '+'�ehri Eklendi...'
					End
-------------------------------------------------------------			
Set		@DistrictName = '-'
Select  @DistrictName = DistrictName
From	Districts 
Where   DistrictName = @GetDistrictName

If (@DistrictName = @GetDistrictName)
					Begin
							Print @GetDistrictName +' '+'�l�esi Mevcuttur.'
					End
If (@DistrictName != @GetDistrictName)
					Begin
							Select  @CityId = CityId, 
									@CountryId = CountryId
							From Cities 
							Where CityName = @GetCityName
						
								Insert Into Districts Values(@GetDistrictName,@CountryId,@CityId, Getdate())

							Print @GetDistrictName +' '+'�l�esi Eklendi...'
					End
-----------------------------------------------------------
Set		@TownName = '-'
Select	@TownName = TownName 
From	Towns
Where	@TownName = @GetTownName

if(@GetTownName = @TownName)
					Begin
							Print @GetTownName +' '+'Mahallesi Mevcuttur.'
					End
if(@GetTownName != @TownName)
					Begin
							Select  @CountryId = CountryId,
									@CityId = CityId,
									@DistrictId = DistrictId
							From Districts 							
							Where DistrictName = @GetDistrictName
							
								Insert Into Towns Values(@GetTownName, @CountryId, @CityId, @DistrictId, GETDATE())

							Print @GetTownName +' '+'Mahallesi Eklendi...'
					End

		

--Execute Stored procedure 

					EXEC sp_AddCountriesToDatabase 'Almanya','Berlin','Tempelhof','Sch�neberg'

-----------------------------------------------------------------------------------------------------

---------------------------------
--�DEV 4
--------------------------------
-- Function �dev 

-- Parametre olarak verilen do�um tarihi ve ya� de�erlerini alarak ki�i belirtilen ya�� Y�l - Ay veya G�n olarak doldurup doldurmad���n� geri d�nen Function

Alter Function AgeCalculate
			(	
				@GetBirthdate	datetime,
				@GetAge			Int
			)
Returns Nvarchar(50)
	Begin
		Declare	@YearHoursDived	Nvarchar(50),		
				@Result			Nvarchar(50)
		Set		@YearHoursDived = DATEDIFF(HOUR , @GetBirthdate , GETDATE())/8766
	
				if(@YearHoursDived = @GetAge)
						Begin
								Set	@Result = 'Dogum Tarihi ��in Ya� Do�ru Girilmi�dir.'
						End

				if(@YearHoursDived != @GetAge)
						Begin
								Set	@Result = 'Dogum Tarihi veya Ya� Yanl��t�r..'
						End
		Return @Result
	End
--Select dbo.AgeCalculate('2000-12-05' , 20) Yanl��d�r �unku 20 yas i�in 12 aral�k ay� girmemi�tir.
Select dbo.AgeCalculate('2000-12-05' , 19)